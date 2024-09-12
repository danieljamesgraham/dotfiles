 call plug#begin()
 " Colour scheme
 Plug 'gruvbox-community/gruvbox'
 " Plug 'ellisonleao/gruvbox.nvim'
 Plug 'joshdick/onedark.vim'
 " Plug 'cocopon/iceberg.vim'
 " Status lines
 Plug 'itchyny/lightline.vim'
 Plug 'edkolev/tmuxline.vim'
 " LSP
 " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 " Quality of life
 Plug 'preservim/nerdtree'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'christoomey/vim-titlecase'
 Plug 'tpope/vim-surround'
 Plug 'tpope/vim-commentary'
 Plug 'google/vim-searchindex'
 " Documents
 Plug 'lervag/vimtex'
 " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'md', 'vim-plug']}
 Plug 'iamcco/markdown-preview.nvim'
 Plug 'mzlogin/vim-markdown-toc'
 Plug 'vimwiki/vimwiki'
 call plug#end()

 " Appearance settings
 syntax on
 if has('termguicolors')
 	set termguicolors
 endif
 set background=dark

 if exists("g:neovide")
 	set guifont=Fira\ Code:h15
 	let g:neovide_hide_mouse_when_typing = v:true
 endif
 
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1

 " Gruvbox
 let g:gruvbox_invert_selection=1
 let g:gruvbox_italic=1
 " let g:gruvbox_contrast_dark='hard'
 colorscheme gruvbox
 let g:lightline = {'colorscheme':'gruvbox'}
 hi clear CursorLine
 hi clear CursorLineNr
 hi CursorLineNr guifg=#ebdbb2
 hi CurSearch guibg=#b8bb26
 hi CurSearch guifg=#282828
 " hi! link SpellBad ErrorMsg
 " hi VimtexTodo cterm=bold guibg=#83a598 guifg=#282828
 hi! link Todo GruvboxRed
 " hi link VimtexTodo GruvboxRed
 hi link texCMD GruvboxGreen
 hi link texPartArgTitle GruvboxRed
 " hi link texTitleArg GruvboxRedBold
 hi link verilogOperator GruvboxBlue
 hi link verilogConditional GruvboxYellow
 hi link verilogLabel GruvboxOrange

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
