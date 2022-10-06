
" Nerd Tree commands and options
noremap <Leader><Leader> :NERDTreeToggle<CR>

" colorscheme gruvbox
colorscheme aldmeris
" let g:aldmeris_termcolors = 'tango'

" ack
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev Ag Ack
cnoreabbrev ag Ack
" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" ctrlp
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " Use ag in CtrlP for listing files. Fast and respects .gitignore
let g:ctrlp_use_caching = 0                           " ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_by_filename = 1      " search by filename by default, that's normally what I want

" deoplete
let g:deoplete#enable_at_startup = 1

" ale
" Using eslint because jshint seems to be the default, but it assumes a rails
" project it seems and wants a config file which is annoying
" Only run linters when saving file
augroup jsx_group
  autocmd!
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
      \ 'elixir': ['credo'],
      \ 'javascript': ['eslint'],
      \ 'jsx': ['eslint'],
      \ 'typescript': ['eslint', 'tslint', 'typecheck'],
      \ 'typescriptreact': ['eslint', 'tslint', 'typecheck'],
      \}

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_default'
let g:airline#extensions#ale#enabled = 1

" COC server

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gs :vsp<CR><Plug>(coc-definition)<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" " vim-rspec mappings
" let g:rspec_command = "Dispatch rspec --format=progress --no-profile {spec}"
" nnoremap <Leader>rc :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>rn :call RunNearestSpec()<CR>
" nnoremap <Leader>rl :call RunLastSpec()<CR>
" nnoremap <Leader>ra :call RunAllSpecs()<CR>
" " For Ruby RSpec
" augroup ruby_cmd
"   autocmd!
"   autocmd BufNewFile,BufRead *_spec.rb compiler rspec
" augroup END

" vim-clojure
let g:vimclojure#HighlightBuiltins = 1
let g:clojure_align_multiline_strings = 1

" ghcmod-vim
if has("mac")
  let g:haddock_browser = "open"
  let g:haddock_browser_callformat = "%s %s"
else
  let g:haddock_browser="/usr/bin/firefox"
endif

