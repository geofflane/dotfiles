
local M = require('usermod.functions');


-- Guard clause prevents redefining function while its being run during the
-- reload which causes an error
-- if (not vim.fn.exists("*reload_config"))
-- then
local function reload_config()
  vim.cmd('source $MYVIMRC')
end

vim.api.nvim_create_user_command('ReloadConfig', reload_config, {desc = 'Reload config again'})
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

