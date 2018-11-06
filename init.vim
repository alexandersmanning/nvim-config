call plug#begin('~/.vim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-markdown'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'jiangmiao/auto-pairs'
  Plug 'airblade/vim-gitgutter'
  Plug 'alvan/vim-closetag'
  Plug 'chemzqm/vim-jsx-improve'
  Plug 'neomake/neomake'
  Plug 'easymotion/vim-easymotion'
  Plug 'gregsexton/MatchTag'
  Plug 'jaawerth/neomake-local-eslint-first'
  Plug 'mileszs/ack.vim'
  Plug 'kristijanhusak/vim-hybrid-material'
  Plug 'fatih/vim-go'
  Plug 'junegunn/goyo.vim'
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-go', { 'do': 'make'}
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'zchee/deoplete-go', { 'do': 'make'}
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
call plug#end()


filetype on
filetype plugin on
filetype indent on
syntax on

" ========== Swap File Options ==========
set dir=$HOME/.vim/tmp/swap
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif

" ========== Theme Options ==========
set t_Co=256
if (has("termguicolors"))
  set termguicolors
endif

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

syntax enable
set background=dark
colorscheme hybrid_reverse

highlight Comment gui=italic
highlight Comment cterm=italic
" ========== Standard Vim Interaction Options ==========
set title
set nowrap
set ruler
set showcmd
set number
set noshowmode
set autoread
set numberwidth=2
set ch=1
set mouse=a "Allow mouse interaction
set shiftwidth=2
set softtabstop=2
set expandtab
set smartcase
set hlsearch
set incsearch  " Search while typing
set ignorecase
set cursorline
set showmatch
set splitright " Always do virtual splits right
set timeoutlen=1000 ttimeoutlen=100           "Reduce Command timeout for faster escape and O
set fileencoding=utf-8 encoding=utf-8         "Set utf-8 encoding on write

" Highlight all trailing white space
" ========== White space handling ==========
match Error /\s\+$/
autocmd InsertEnter * match Error /\s\+\%#\@<!$/
autocmd InsertLeave * match Error /\s\+$/

" ========== GUI Options =====
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=r
set guioptions-=l
set linespace=8
set guifont=Menlo\ for\ Powerline:h14

hi clear CursorLine
augroup CLClear
  autocmd! ColorScheme * hi clear CursorLine
augroup END

" ========= Airline Theme =========
set hidden
let g:airline_powerline_fonts = 1
let g:airline_theme = "hybrid"
"let g:airline_theme='oceanicnext'
let g:airline_section_y = '%{substitute(getcwd(), expand("$HOME"), "~", "g")}'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '                                 "Left separator for tabline
let g:airline#extensions#tabline#left_alt_sep = '│'                             "Right separator for tabline

let g:used_javascript_libs = 'angularjs,d3,react,angularuirouter'

" ======= Mapping ===============
let mapleader=" "
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Leader>c :bp<bar>sp<bar>bn<bar>bd!<CR> " This kills the current buffer without destroying split
"nnoremap <Leader>c :bp\|bd #<CR> " This kills the current buffer without destroying split
nnoremap <CR> :noh<CR><CR>  " This unsets highlighting when enter is hit again
nnoremap <C-p> :FZF -m<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
nnoremap <C-k> :bnext<CR>
nnoremap <C-j> :bprev<CR>
nnoremap <Leader>b :ls<CR>:b<Space>
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
map ; :
com! FormatJSON %!python -m json.tool
nnoremap <Leader>t :terminal<CR>i
tnoremap <C-c> <C-\><C-n>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" stay highlighted after shift
vnoremap < <gv
vnoremap > >gv

" Copy current file path
nmap cp :let @" = expand("%")<CR>

" ======= Scrolling ========
set scrolloff=8
set sidescroll=5

" ========== NERDTree ============
" Open nerdree automatically when vim starts up if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Toggle NerdTree
map <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.git$', '\.sass-cache$']
" Close vim when only NERD tree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ========== HTML CloseTag ==========
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'

" ========== Sytastic ==========
let g:neomake_javascript_eslint_exe = nrun#Which('eslint')
let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake

" =========== FZF ==============
if has('nvim')
  aug fzf_setup
    au!
    au TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  aug END
end

" ======== Markdown ========
let g:markdown_fenced_languages = ['python', 'ruby', 'javascript']

augroup filetype_ruby
  autocmd!
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal expandtab
augroup END

augroup filetype_javascript
  autocmd!
  autocmd FileType javascript setlocal shiftwidth=2
  autocmd FileType javascript setlocal softtabstop=2
  autocmd FileType javascript setlocal expandtab
augroup END

augroup filetype_html
  autocmd!
  autocmd FileType html setlocal shiftwidth=2
  autocmd FileType html setlocal softtabstop=2
  autocmd FileType html setlocal expandtab
augroup END

augroup go
  au FileType go set noexpandtab
  au FileType go set shiftwidth=4
  au FileType go set softtabstop=4
  au FileType go set tabstop=4
augroup END

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup end

" ======== Deoplete ======== 
let g:acp_enableAtStartup = 0
set completeopt-=preview
set completeopt+=noselect
" Use neocomplete.
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#enable_at_startup=1
let g:deoplete#smart_case=1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#omni#input_patterns = {}
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"------------------------------------------------------------------------------
" Vim-go
"------------------------------------------------------------------------------
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt" "Explicited the formater plugin (gofmt, goimports, goreturn...)

" Show a list of interfaces which is implemented by the type under your cursor
au FileType go nmap <Leader>s <Plug>(go-implements)

" Show type info for the word under your cursor
au FileType go nmap <Leader>i <Plug>(go-info)

" Open the relevant Godoc for the word under the cursor
au FileType go nmap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" Open the Godoc in browser
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" Run/build/test/coverage
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" By default syntax-highlighting for Functions, Methods and Structs is disabled.
" Let's enable them!
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
