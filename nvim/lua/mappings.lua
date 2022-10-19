local M = require('usermod.functions');
local bind = M.bind

-- Clear search highlights by pressing return
bind('n', '<CR>', ':nohlsearch<CR>', {noremap = true, silent = true})

-- -- netrw file browsing
-- autocmd FileType netrw setl bufhidden=delete -- Don't try and save these buffers
-- -- Open files with double click, don't navigate up which is stupid
-- autocmd FileType netrw nmap <2-leftmouse> <CR>
-- let g:netrw_mousemaps = 0      -- The mouse in netrw does whacky things
-- let g:netrw_liststyle = 1      -- Tree style is nice, but it's buggy as hell
-- let g:netrw_banner = 1         -- The banner is terrible, but netrw is buggy as hell without it
-- let g:netrw_keepdir= 0         -- Keep current directory same as browsing directory

-- Tab mappings.
bind('', '<Leader>tt', ':tabnew<cr>', {noremap = true})
bind('', '<Leader>te', ':tabedit', {noremap = true})
bind('', '<Leader>tc', ':tabclose<cr>', {noremap = true})
bind('', '<Leader>to', ':tabonly<cr>', {noremap = true})
bind('', '<Leader>tn', ':tabnext<cr>', {noremap = true})
bind('', '<Leader>tp', ':tabprevious<cr>', {noremap = true})
bind('', '<Leader>tf', ':tabfirst<cr>', {noremap = true})
bind('', '<Leader>tl', ':tablast<cr>', {noremap = true})
bind('', '<Leader>tm', ':tabmove', {noremap = true})

if (vim.fn.has('mac') == 0)
then
  -- Let's have some regular keybindings for copy and paste
  bind('v', '<C-c>', '"+y')
  bind('v', '<C-x>', '"+x')
  bind('v', '<C-v>', 'c<ESC>"+gf')
  bind('i', '<C-v>', '<C-r><C-o>+')
end

-- Quickly turn on/off wrapping
bind('', '<Leader>ee', ':set nowrap<CR>', {noremap = true})
bind('', '<Leader>ww', ':set wrap<CR>', {noremap = true})

-- Guard clause prevents redefining function while its being run during the
-- reload which causes an error
-- if (not vim.fn.exists("*reload_config"))
-- then
local function reload_config()
  vim.cmd('source $MYVIMRC')
end

vim.api.nvim_create_user_command('ReloadConfig', reload_config, {desc = 'Reload config again'})
-- Quickly edit and reload vimrc
bind('', '<Leader>ev', ':tabedit $MYVIMRC<cr>', {noremap = true})
bind('', '<Leader>rv', ':ReloadConfig<cr>', {noremap = true})

-- Change the directory to the path of the current file
bind('', '<Leader>cd', ':cd %:p:h<cr>', {noremap = true})

-- K on a type shows definition
bind('n', 'K', ':call CocAction(\'doHover\')<CR>', {noremap = true, silent = true})

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

vim.api.nvim_create_user_command('DeleteWS', M.delete_trailing_ws, {desc = 'Delete trailing whitespace'})
bind('', '<Leader>x', ':DeleteWS<CR>', {noremap = true})

-- TODO: Lua?
-- -- command! -register CopyMatches call CopyMatches(<q-reg>)
-- function copy_matches(reg)
--   let hits = []
--   %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
--   let reg = empty(a:reg) ? '+' : a:reg
--   execute 'let @'.reg.' = join(hits, "\n") . "\n"'
-- end
-- vim.api.nvim_create_user_command('CopyMatches', copy_matches, {desc = ''})

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

vim.api.nvim_create_user_command('BufOnly', function(args)
  M.buf_only(args.buffer, args.bang)
end, {nargs = '?', bang = 1, complete = 'buffer'})
vim.api.nvim_create_user_command('BufClose', function(args)
  M.buf_close(args.buffer, args.bang)
end, {nargs = '?', bang = 1, complete = 'buffer'})

