
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

" syntasctic
" Using eslint because jshint seems to be the default, but it assumes a rails
" project it seems and wants a config file which is annoying
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_javascript_eslint_generic = 1
let g:syntastic_javascript_eslint_exec = '/bin/ls'
let g:syntastic_javascript_eslint_exe='assets/node_modules/.bin/eslint'
let g:syntastic_javascript_eslint_args='-f compact'

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_default'


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

