
let mapleader="\\"  " Make it explicit so plugins like paredit will pick it up

" Clear search highlights by pressing return
nnoremap <silent> <CR> :nohlsearch<CR>

" netrw file browsing
autocmd FileType netrw setl bufhidden=delete " Don't try and save these buffers
" Open files with double click, don't navigate up which is stupid
autocmd FileType netrw nmap <2-leftmouse> <CR>
let g:netrw_mousemaps = 0      " The mouse in netrw does whacky things
let g:netrw_liststyle = 1      " Tree style is nice, but it's buggy as hell
let g:netrw_banner = 1         " The banner is terrible, but netrw is buggy as hell without it
let g:netrw_keepdir= 0         " Keep current directory same as browsing directory
" noremap <Leader><Leader> :15Lexplore<CR>

" Tab mappings.
noremap <Leader>tt :tabnew<cr>
noremap <Leader>te :tabedit
noremap <Leader>tc :tabclose<cr>
noremap <Leader>to :tabonly<cr>
noremap <Leader>tn :tabnext<cr>
noremap <Leader>tp :tabprevious<cr>
noremap <Leader>tf :tabfirst<cr>
noremap <Leader>tl :tablast<cr>
noremap <Leader>tm :tabmove

if ! has("mac")
  " Let's have some regular keybindings for copy and paste
  vmap <C-c> "+y
  vmap <C-x> "+x
  vmap <C-v> c<ESC>"+gf
  imap <C-v> <C-r><C-o>+
endif

" Quickly turn on/off wrapping
noremap <Leader>ee :set nowrap<CR>
noremap <Leader>ww :set wrap<CR>

" Quickly edit and reload vimrc
noremap <Leader>ev :tabedit $MYVIMRC<cr>
noremap <Leader>rv :call ReloadConfigs()<cr>

" Guard clause prevents redefining function while its being run during the
" reload which causes an error
if !exists("*ReloadConfigs")
func! ReloadConfigs()
  source $MYVIMRC
  if has('gui_running')
    source $MYGVIMRC
  endif
endfunc
endif

" Change the directory to the path of the current file
noremap <Leader>cd :cd %:p:h<cr>

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType r setlocal shiftwidth=2
autocmd FileType R setlocal shiftwidth=2

command! DeleteWS call DeleteTrailingWS()
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
noremap <Leader>x :<C-U>call DeleteTrailingWS()<CR>

command! -register CopyMatches call CopyMatches(<q-reg>)
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

augroup enter_grp
  autocmd!
  " Remap <CR> onto itself to make Return and Enter work the same way (open
  " the file into the edit window)
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
augroup END

augroup lang_grp
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript
augroup END

