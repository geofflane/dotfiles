
local M = {}

function M.bind(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.delete_trailing_ws()
  -- Save cursor position to later restore
  local curpos = vim.api.nvim_win_get_cursor(0)

  -- Search and replace trailing whitespace
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, curpos)
end

-- Returns the current buffer or -1 if one wasn't found
local function current_buffer(buffer)
  if (buffer == '' or buffer == nil)
    then
    -- No buffer provided, use the current buffer.
    return vim.fn.bufnr('%')
  end

  if (buffer + 0) > 0
    then
    -- A buffer number was provided, returns -1 if none found
    return vim.fn.bufnr(buffer + 0)
  else
    -- A buffer name was provided, returns -1 if none found.
    return vim.fn.bufnr(buffer)
  end
end

-- buf_only  -  Delete all the buffers except the current/named buffer.
-- buf_close -  Close a buffer without closing the window it's in.
-- Usage:
--
-- :Bonly / :BOnly / :Bufonly / :BufOnly [buffer]
-- :BufClose[!] [buffer]
--
-- Without any arguments the current buffer is kept.  With an argument the
-- buffer name/number supplied is kept.

-- Recommended
-- command! -nargs=? -complete=buffer -bang Bonly :call BufOnly('<args>', '<bang>')
-- command! -nargs=? -complete=buffer -bang BOnly :call BufOnly('<args>', '<bang>')
-- command! -nargs=? -complete=buffer -bang Bufonly :call BufOnly('<args>', '<bang>')
-- command! -nargs=? -complete=buffer -bang BufOnly :call BufOnly('<args>', '<bang>')
-- command! -nargs=? -complete=buffer -bang BufClose :call BufClose(expand('<args>'), expand('<bang>'))

function M.buf_only(buffer, bang)
  local cur_buffer = current_buffer(buffer)
  if (cur_buffer == -1)
    then
    vim.api.nvim_echo({{string.format("No matching buffer for %s.", buffer), 'ErrorMsg'}}, true, {})
    return
  end

  local last_buffer = vim.fn.bufnr('$')

  local delete_count = 0
  local n = 1
  local bang_symbol = '';
  if (bang) then
    bang_symbol = '!'
  end

  while n <= last_buffer do
    if n ~= cur_buffer and vim.fn.buflisted(n) == 1
      then
      if (not bang and vim.fn.getbufvar(n, '&modified') == 1)
        then
        vim.api.nvim_echo({{'No write since last change for cur_buffer (add ! to override)', 'ErrorMsg'}}, true, {})
      else
        vim.cmd(string.format("silent exe 'bdel%s' %d", bang_symbol, n))
        if (vim.fn.buflisted(n) == 0)
          then
          delete_count = delete_count + 1
        end
      end
    end
    n = n+1
  end

  if (delete_count == 1)
    then
    vim.api.nvim_echo({{string.format('%d buffer deleted', delete_count)}}, true, {})
  elseif delete_count > 1
    then
    vim.api.nvim_echo({{string.format('%d buffers deleted', delete_count)}}, true, {})
  end
end

function M.buf_close(buffer, bang)
  local cur_buffer = current_buffer(buffer)
  if (cur_buffer == -1)
    then
    vim.api.nvim_echo({{string.format('No matching buffer for %s', buffer), 'ErrorMsg'}}, true, {})
    return
  end

  local current_window = vim.fn.winnr()
  local buffer_window = vim.fn.bufwinnr(cur_buffer)

  if (buffer_window == -1)
    then
    vim.api.nvim_echo({{string.format("Buffer %s isn't open in any windows.", cur_buffer), 'ErrorMsg'}}, true, {})
    return
  end

  if (not bang and vim.fn.getbufvar(cur_buffer, '&modified') == 1)
    then
    vim.api.nvim_echo({{string.format('No write since last change for buffer %s (add ! to override)', cur_buffer), 'ErrorMsg'}}, true, {})
    return
  end

  local bang_symbol = '';
  if (bang) then
    bang_symbol = '!'
  end

  -- Move to the proper window if necessary, open a blank buffer,
  -- then move back to the original window...
  if (buffer_window >= 0)
    then
    if (current_window == buffer_window)
      then
      if (vim.fn.exists('g:BufClose_AltBuffer') == 1)
        then
        vim.cmd(string.format("exe 'e%s'  g:BufClose_AltBuffer", bang_symbol))
      else
        vim.cmd(string.format("exe 'enew%s'", bang_symbol))
      end
    else
      vim.cmd(string.format('exe %s\\<C-w>w', buffer_window))
      if (vim.fn.exists('g:BufClose_AltBuffer') == 1)
        then
        vim.cmd(string.format("exe 'e%s'  g:BufClose_AltBuffer", bang_symbol))
      else
        vim.cmd(string.format("exe 'enew%s'", bang_symbol))
      end
      vim.cmd(string.format('exe %s\\<C-w>w', current_window))
    end
  end

  -- ...and delete the specified buffer.
  vim.cmd(string.format("silent exe 'bdel%s' %s", bang_symbol, cur_buffer))
end


return M
