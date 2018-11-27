call plug#begin('~/.vim/plugged')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-markdown'
  Plug 'airblade/vim-gitgutter'
  Plug 'alvan/vim-closetag'
  Plug 'mileszs/ack.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'vim-syntastic/syntastic'
  Plug 'kaicataldo/material.vim'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'Valloric/YouCompleteMe'
call plug#end()

set encoding=utf-8

filetype on
filetype plugin on
filetype indent on
syntax on

" Enable deoplete when InsertEnter.
"let g:python3_host_prog = '/usr/local/bin/python3'
"let g:deoplete#enable_at_startup = 1
"autocmd InsertEnter * call deoplete#enable()


" ========== Swap File Options ==========
set dir=$HOME/.vim/tmp/swap
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif
" ========== Theme Options ==========
set t_Co=256
syntax enable

highlight Comment gui=italic
highlight Comment cterm=italic

colorscheme material

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

let g:material_theme_style='dark'
let g:material_terminal_italics = 1
set background=dark

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
set cursorline
set splitright " Always do virtual splits right
set timeoutlen=1000 ttimeoutlen=200        "Reduce Command timeout for faster escape and O
set fileencoding=utf-8 encoding=utf-8         "Set utf-8 encoding on write

" Highlight all trailing white space
" ========== White space handling ==========
match Error /\s\+$/
autocmd InsertEnter * match Error /\s\+\%#\@<!$/
autocmd InsertLeave * match Error /\s\+$/

" ========== GUI Options ==========
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
let g:airline_theme = 'material'
let g:airline_powerline_fonts = 1
let g:airline_section_y = '%{substitute(getcwd(), expand("$HOME"), "~", "g")}'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '                                 "Left separator for tabline
let g:airline#extensions#tabline#left_alt_sep = '│'                             "Right separator for tabline

com! FormatJSON %!python -m json.tool
" stay highlighted after shift
vnoremap < <gv
vnoremap > >gv

" Copy current file path
nmap cp :let @" = expand("%")<CR>

" ======= Mapping ===============
let mapleader=" "
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Leader>c :bp<bar>sp<bar>bn<bar>bd<CR> " This kills the current buffer without destroying split
"nnoremap <Leader>c :bp\|bd #<CR> " This kills the current buffer without destroying split
nnoremap <CR> :noh<CR><CR>  " This unsets highlighting when enter is hit again

nnoremap <C-k> :bnext<CR>
nnoremap <C-j> :bprev<CR>
nnoremap <Leader>b :ls<CR>:b<Space>
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
map ; :

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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

nnoremap <C-p> :FZF -m<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
