call plug#begin()
" Colour scheme
Plug 'cocopon/iceberg.vim'
" Status lines
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
" Quality of life
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'google/vim-searchindex'
" Plug 'Yggdroot/indentLine'
" Documents
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" Appearance settings
syntax on
if has('termguicolors')
	set termguicolors
endif
set background=dark
colorscheme iceberg
hi Normal guibg=NONE
hi Comment cterm=italic
hi clear CursorLine
hi CursorLineNr guibg=#1e2132
hi Visual guibg=#c99a76
hi Visual guifg=#1e2132
hi MatchParen cterm=bold,underline
hi CurSearch guibg=#b5bd88
hi CurSearch guifg=#1e2132

" Testing appearance
" hi LineNr guibg=#161821
" hi Normal guifg=#cdd1e6
" hi Normal guibg=#1e2132
" hi CursorLine guibg=#161821
" hi CursorLineNr cterm=bold
" hi Normal guibg=#1e2132
" hi CursorLineNr guibg=#444b71

" Status lines
let g:lightline = {'colorscheme': 'iceberg'}
let g:tmuxline_powerline_separators=0
let g:tmuxline_preset='minimal'

" Vim settings
set laststatus=2 " Status line
set nu rnu " Line numbers (relative)
set wrap
set cursorline
set linebreak
set ruler
set autoindent
set mouse=a
set clipboard=unnamed
set ts=4 sw=4
set encoding=utf-8
set hlsearch
set noshowmode
set scrolloff=8
set autoread
set complete-=i
set foldmethod=manual
let g:markdown_fenced_languages = ['python', 'bash=sh']

" Vimtex
filetype plugin on
let g:vimtex_view_method = 'skim'
" let g:vimtex_syntax_enabled = 0

" Filetype specific
autocmd BufNewFile,BufRead *.v,*.vs set syntax=verilog
autocmd BufNewFile,BufRead *.pio set syntax=c
autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.md set spell
