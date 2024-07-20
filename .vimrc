call plug#begin()
" Colour scheme
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
" Plug 'cocopon/iceberg.vim'
" Status lines
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
" Quality of life
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-titlecase'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'google/vim-searchindex'
" Documents
Plug 'lervag/vimtex'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" Appearance settings
syntax on
if has('termguicolors')
	set termguicolors
endif
set background=dark

" OneDark
let g:onedark_terminal_italics=1
colorscheme onedark
let g:lightline = { 'colorscheme': 'onedark', }
" hi Normal guibg=#1e222a
hi Normal guibg=NONE
hi clear CursorLine " No CursorLine style
" hi MatchParen cterm=bold,underline
hi MatchParen cterm=NONE
hi MatchParen guibg=#61afef
hi MatchParen guifg=#1e222a
hi CurSearch guibg=#98c379
hi CurSearch guifg=#1e222a
hi Visual guibg=#e5c07b
hi Visual guibg=#c678dd
hi Visual guifg=#1e222a
hi SpellBad guibg=#e06c75
hi SpellBad guifg=#1e222a

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
set wildmenu
set spellsuggest+=10
let g:markdown_fenced_languages = ['python', 'bash=sh']

" Smoothscrolling and display wrapped text
set wrap smoothscroll
set display=lastline

nnoremap \s ea<C-X><C-S>

" Vimtex
filetype plugin on
let g:vimtex_view_method = 'skim'
let g:vimtex_matchparen_enabled = 0
" let g:vimtex_syntax_enabled = 0

" Filetype specific
autocmd BufNewFile,BufRead *.v,*.vs set syntax=verilog
autocmd BufNewFile,BufRead *.pio set syntax=c
autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.md set spell

" " Iceberg
" colorscheme iceberg
" let g:lightline = {'colorscheme': 'iceberg'}
" hi Normal guibg=NONE
" hi Comment cterm=italic
" hi clear CursorLine
" hi CursorLineNr guibg=#1e2132
" hi Visual guibg=#c99a76
" hi Visual guifg=#1e2132
" hi MatchParen cterm=bold,underline
" hi CurSearch guibg=#b5bd88
" hi CurSearch guifg=#1e2132
" " hi LineNr guibg=#161821
" " hi Normal guifg=#cdd1e6
" " hi Normal guibg=#1e2132
" " hi CursorLine guibg=#161821
" " hi CursorLineNr cterm=bold
" " hi Normal guibg=#1e2132
" " hi CursorLineNr guibg=#444b71

" " Gruvbox
" let g:gruvbox_invert_selection=0
" let g:gruvbox_italic=1
" " let g:gruvbox_contrast_dark='hard'
" colorscheme gruvbox
" let g:lightline = {'colorscheme':'gruvbox'}
" hi clear CursorLine
" hi clear CursorLineNr
" hi CursorLineNr guifg=#ebdbb2
" hi CurSearch guibg=#b8bb26
" hi CurSearch guifg=#282828
" hi! link SpellBad ErrorMsg
" " hi VimtexTodo cterm=bold guibg=#83a598 guifg=#282828
" hi link texCMD GruvboxGreen
" hi link texPartArgTitle GruvboxRed
" " hi link texTitleArg GruvboxRedBold
" hi link verilogOperator GruvboxBlue
" hi link verilogConditional GruvboxYellow
" hi link verilogLabel GruvboxOrange
