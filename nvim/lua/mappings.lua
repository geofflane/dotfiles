function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Clear search highlights by pressing return
map('n', '<CR>', ':nohlsearch<CR>', {noremap = true, silent = true})

-- -- netrw file browsing
-- autocmd FileType netrw setl bufhidden=delete -- Don't try and save these buffers
-- -- Open files with double click, don't navigate up which is stupid
-- autocmd FileType netrw nmap <2-leftmouse> <CR>
-- let g:netrw_mousemaps = 0      -- The mouse in netrw does whacky things
-- let g:netrw_liststyle = 1      -- Tree style is nice, but it's buggy as hell
-- let g:netrw_banner = 1         -- The banner is terrible, but netrw is buggy as hell without it
-- let g:netrw_keepdir= 0         -- Keep current directory same as browsing directory

-- Tab mappings.
map('', '<Leader>tt', ':tabnew<cr>', {noremap = true})
map('', '<Leader>te', ':tabedit', {noremap = true})
map('', '<Leader>tc', ':tabclose<cr>', {noremap = true})
map('', '<Leader>to', ':tabonly<cr>', {noremap = true})
map('', '<Leader>tn', ':tabnext<cr>', {noremap = true})
map('', '<Leader>tp', ':tabprevious<cr>', {noremap = true})
map('', '<Leader>tf', ':tabfirst<cr>', {noremap = true})
map('', '<Leader>tl', ':tablast<cr>', {noremap = true})
map('', '<Leader>tm', ':tabmove', {noremap = true})

-- if (not vim.fn.has('mac'))
-- then
--   -- Let's have some regular keybindings for copy and paste
--   vmap <C-c> "+y
--   vmap <C-x> "+x
--   vmap <C-v> c<ESC>"+gf
--   imap <C-v> <C-r><C-o>+
-- end

-- Quickly turn on/off wrapping
map('', '<Leader>ee', ':set nowrap<CR>', {noremap = true})
map('', '<Leader>ww', ':set wrap<CR>', {noremap = true})

-- Quickly edit and reload vimrc
map('', '<Leader>ev', ':tabedit $MYVIMRC<cr>', {noremap = true})
map('', '<Leader>rv', ':call reload_config()<cr>', {noremap = true})

-- Guard clause prevents redefining function while its being run during the
-- reload which causes an error
-- if (not vim.fn.exists("*reload_config"))
-- then
function reload_config()
  vim.cmd('source $MYVIMRC')
  if(vim.fn.has('gui_running'))
  then
    vim.cmd('source $MYGVIMRC')
  end
end
-- end

-- Change the directory to the path of the current file
map('', '<Leader>cd', ':cd %:p:h<cr>', {noremap = true})

-- K on a type shows definition
map('n', 'K', ':call CocAction(\'doHover\')<CR>', {noremap = true, silent = true})

-- Automatic fold settings for specific files. Uncomment to use.
-- autocmd FileType ruby setlocal foldmethod=syntax
-- autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
vim.api.nvim_create_augroup('folding_grp', {clear = true})
vim.api.nvim_create_autocmd('FileType', {
    group = 'folding_grp',
    pattern = {'r'},
    command = 'setlocal shiftwidth=2',
})
vim.api.nvim_create_autocmd('FileType', {
    group = 'folding_grp',
    pattern = {'R'},
    command = 'setlocal shiftwidth=2',
})

vim.cmd('command! DeleteWS call delete_trailing_ws()')
function delete_trailing_ws()
  -- TODO: Can this be done in Lua?
  vim.cmd [[
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
  ]]
end
map('', '<Leader>x', ':<C-U>call delete_trailing_ws()<CR>', {noremap = true})

-- TODO: Lua?
-- command! -register CopyMatches call CopyMatches(<q-reg>)
-- function copy_matches(reg)
--   let hits = []
--   %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
--   let reg = empty(a:reg) ? '+' : a:reg
--   execute 'let @'.reg.' = join(hits, "\n") . "\n"'
-- end

-- Remap <CR> onto itself to make Return and Enter work the same way (open
-- the file into the edit window)
vim.api.nvim_create_augroup('lang_grp', {clear = true})
vim.api.nvim_create_autocmd('BufReadPost', {
    group = 'lang_grp',
    pattern = {'quickfix'},
    command = 'nnoremap <buffer> <CR> <CR>',
})

vim.api.nvim_create_augroup('lang_grp', {clear = true})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    group = "lang_grp",
    pattern = {'*.es6'},
    command = "setfiletype javascript",
})

