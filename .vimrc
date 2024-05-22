call plug#begin()
" Colour schemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'sainnhe/sonokai'
Plug 'nanotech/jellybeans.vim'
" Status lines
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
" Quality of life
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'google/vim-searchindex'
" Document compliers
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" Enable colour
syntax on
if has('termguicolors')
	set termguicolors
endif

" " Unused colourscheme
" colorscheme dracula
" let g:dracula_colorterm = 0
" let g:dracula_italic = 0
" colorscheme solarized
" set background=dark
" highlight Normal ctermbg=None
" colorscheme gruvbox
" let g:gruvbox_contrast_dark='hard'

" " 4 bit color scheme
" set t_Co=16
" highlight LineNr ctermfg=Grey
" highlight NonText ctermfg=DarkGrey
" highlight StatusLine ctermfg=DarkGrey
" highlight MatchParen cterm=underline,bold ctermbg=NONE
" highlight Comment ctermfg=DarkGrey
" highlight Identifier ctermfg=DarkGrey

" Appearance settings

" let g:sonokai_better_performance=1
" colorscheme sonokai
" let g:lightline={ 'colorscheme': 'sonokai', }

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
let g:lightline={ 'colorscheme': 'gruvbox', }

" let g:jellybeans_use_term_italics = 1
" colorscheme jellybeans
" let g:lightline={ 'colorscheme': 'jellybeans', }

let g:tmuxline_powerline_separators=0
let g:tmuxline_preset='minimal'
" let g:mkdp_theme='light'

" hi MatchParen cterm=underline,bold

" Vim settings
set laststatus=2 " Status line
set nu rnu " Line numbers (relative)
set wrap
set linebreak
set ruler
set autoindent
set mouse=a
set clipboard=unnamed
set ts=4 sw=4
set encoding=utf-8
set hlsearch
set noshowmode

" Vimtex settings
filetype plugin on
let g:vimtex_view_method = 'skim'
" let g:vimtex_syntax_enabled = 0

" Filetype specific settings
autocmd BufNewFile,BufRead *.v,*.vs set syntax=verilog
autocmd BufNewFile,BufRead *.pio set syntax=c
