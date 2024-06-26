-- Clear search highlights by pressing return
vim.keymap.set('n', '<CR>', ':nohlsearch<CR>', {noremap = true, silent = true})

-- -- netrw file browsing
-- autocmd FileType netrw setl bufhidden=delete -- Don't try and save these buffers
-- -- Open files with double click, don't navigate up which is stupid
-- autocmd FileType netrw nmap <2-leftmouse> <CR>
-- let g:netrw_mousemaps = 0      -- The mouse in netrw does whacky things
-- let g:netrw_liststyle = 1      -- Tree style is nice, but it's buggy as hell
-- let g:netrw_banner = 1         -- The banner is terrible, but netrw is buggy as hell without it
-- let g:netrw_keepdir= 0         -- Keep current directory same as browsing directory

-- Tab mappings.
vim.keymap.set('', '<Leader>tt', ':tabnew<cr>', {noremap = true})
vim.keymap.set('', '<Leader>te', ':tabedit', {noremap = true})
vim.keymap.set('', '<Leader>tc', ':tabclose<cr>', {noremap = true})
vim.keymap.set('', '<Leader>to', ':tabonly<cr>', {noremap = true})
vim.keymap.set('', '<Leader>tn', ':tabnext<cr>', {noremap = true})
vim.keymap.set('', '<Leader>tp', ':tabprevious<cr>', {noremap = true})
vim.keymap.set('', '<Leader>tf', ':tabfirst<cr>', {noremap = true})
vim.keymap.set('', '<Leader>tl', ':tablast<cr>', {noremap = true})
vim.keymap.set('', '<Leader>tm', ':tabmove', {noremap = true})


if (vim.fn.has('mac') == 0)
then
  -- Let's have some regular keyvim.keymap.settings for copy and paste
  vim.keymap.set('v', '<C-c>', '"+y')
  vim.keymap.set('v', '<C-x>', '"+x')
  vim.keymap.set('v', '<C-v>', 'c<ESC>"+gf')
  vim.keymap.set('i', '<C-v>', '<C-r><C-o>+')
end

-- Quickly turn on/off wrapping
vim.keymap.set('', '<Leader>ee', ':set nowrap<CR>', {noremap = true})
vim.keymap.set('', '<Leader>ww', ':set wrap<CR>', {noremap = true})

-- Quickly edit and reload vimrc
vim.keymap.set('', '<Leader>ev', ':tabedit $MYVIMRC<cr>', {noremap = true})
vim.keymap.set('', '<Leader>rv', ':ReloadConfig<cr>', {noremap = true})

-- Change the directory to the path of the current file
vim.keymap.set('', '<Leader>cd', ':cd %:p:h<cr>', {noremap = true})

-- K on a type shows definition
vim.keymap.set('n', 'K', ':call CocAction(\'doHover\')<CR>', {noremap = true, silent = true})

vim.keymap.set('', '<Leader>x', ':DeleteWS<CR>', {noremap = true})

