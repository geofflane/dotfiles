
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
nmap <silent> <C-]> :call CocAction('jumpDefinition')<CR>
nmap <silent> gs :call CocAction('jumpDefinition', 'vsplit')<CR>


" vim-rspec mappings
let g:rspec_command = "Dispatch rspec --format=progress --no-profile {spec}"
nnoremap <Leader>rc :call RunCurrentSpecFile()<CR>
nnoremap <Leader>rn :call RunNearestSpec()<CR>
nnoremap <Leader>rl :call RunLastSpec()<CR>
nnoremap <Leader>ra :call RunAllSpecs()<CR>
" For Ruby RSpec
augroup ruby_cmd
  autocmd!
  autocmd BufNewFile,BufRead *_spec.rb compiler rspec
augroup END

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

