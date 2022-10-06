function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Clear search highlights by pressing return
map('n', '<CR>', ':nohlsearch<CR>', {noremap = true, silent = true})

-- netrw file browsing
autocmd FileType netrw setl bufhidden=delete -- Don't try and save these buffers
-- Open files with double click, don't navigate up which is stupid
autocmd FileType netrw nmap <2-leftmouse> <CR>
let g:netrw_mousemaps = 0      -- The mouse in netrw does whacky things
let g:netrw_liststyle = 1      -- Tree style is nice, but it's buggy as hell
let g:netrw_banner = 1         -- The banner is terrible, but netrw is buggy as hell without it
let g:netrw_keepdir= 0         -- Keep current directory same as browsing directory
-- noremap <Leader><Leader> :15Lexplore<CR>

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
map('', '<Leader>rv', ':call ReloadConfigs()<cr>', {noremap = true})

-- Guard clause prevents redefining function while its being run during the
-- reload which causes an error
if (not vim.fn.exists("*ReloadConfigs"))
then
func! ReloadConfigs()
  vim.cmd('source $MYVIMRC')
  if(vim.fn.has('gui_running'))
  then
    vim.cmd('source $MYGVIMRC')
  end
endfunc
end

-- Change the directory to the path of the current file
map('', '<Leader>cd', ':cd %:p:h<cr>', {noremap = true})

-- K on a type shows definition
map('n', 'K', ':call CocAction('doHover')<CR>', {noremap = true, silent = true})

-- Automatic fold settings for specific files. Uncomment to use.
-- autocmd FileType ruby setlocal foldmethod=syntax
-- autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType r setlocal shiftwidth=2
autocmd FileType R setlocal shiftwidth=2

command! DeleteWS call DeleteTrailingWS()
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
map('', '<Leader>x', ':<C-U>call DeleteTrailingWS()<CR>', {noremap = true})

command! -register CopyMatches call CopyMatches(<q-reg>)
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

augroup enter_grp
  autocmd!
  -- Remap <CR> onto itself to make Return and Enter work the same way (open
  -- the file into the edit window)
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

augroup lang_grp
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript
augroup END

