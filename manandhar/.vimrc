" Plugins
so ~/.vim/plugins.vim

" MAPPINGS ------------------------------------------------ {{{
nmap <F8> :TagbarTogggle<CR>
" noremap <Esc> :noh<CR>


" }}}

" VIMSCRIPT ------------------------------------------------ {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" Different cursor in NORMAL and INSERT mode
if has ("autocmd")
	au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
	au InsertEnter,InsertChange *
				\ if v:insertmode == 'i' |
				\	silent execute '!echo -ne "\e[5 q"' | redraw! |
				\ elseif v:insertmode == 'r' |
				\	silent execute '!echo -ne "\e[3 q"' | redraw! |
				\ endif
	au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif
set ttimeout
set ttimeoutlen=1
set ttyfast

" }}}


" Disable compatibility with vi which can cause unexpected issues
set nocompatible

" Line Numbering
set relativenumber

" Syntax and Indentation Support
syntax on

" Highlight cursor line underneath the cursor horizontally
set cursorline

" Highlight cursor line underneath the cursor vertically
set cursorcolumn

" Set shift width to 4 spaces
set shiftwidth=4

" Set tab width to 4 columns
set tabstop=4

" Use space characters instead of tabs
" set expandtab

" Use highlighting when doing a search
set hlsearch

" Set the commands to save in history (default is 20)
set history=1000


" Theme
set t_Co=256
set bg=dark
colorscheme gruvbox

" Airline status line theme
let g:airline_theme='angr'
let g:airline_powerline_fonts=1

" Indent Guides
let g:indent_guides_enable_on_vim_startup=1

" Turn off error beeping and flashing
" set belloff=all
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Enable mouse support
set mouse=a

" Rainbow
let g:rainbow_active=1

" Javascript Language Support
let g:javascript_plugin_jsdoc=1

" Autoformat
let g:formatdef_javascript='"prettier --write" %s'
au BufWritePre * Autoformat

" Always show hidden files in NERDTree
let g:NERDTreeShowHidden=1

" Icons in NERDTree
let g:NERDTreeGitStatusUseXicons=1
let g:NERDTreeGitStatusUseNerdFonts=1

" ALE
highlight AleErrorUnderline cterm=underline ctermfg=red
highlight AleWarningUnderline cterm=underline ctermfg=yellow
highlight AleErrorSign ctermfg=red
highlight AleWarningSign ctermfg=yellow

let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {}
" let g:ale_sign_error = '✖'
" let g:ale_sign_warning = '⚠'
let g:ale_sign_error='>>'
let g:ale_sign_warning='>>'
let g:ale_sign_error_highlight = 'AleErrorUnderline'
let g:ale_sign_warning_highlight = 'AleWarningUnderline'

highlight link ALEErrorLine AleErrorUnderline
highlight link ALWarningLine AleWarningUnderline
sign define AleErrorSign texthl=AleErrorSign
sign define AleWarningSign texthl=AleWarningSign

