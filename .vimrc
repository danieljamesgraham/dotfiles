call plug#begin()
" Gruvbox
Plug 'gruvbox-community/gruvbox'
" Status line
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
" Navigation
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'google/vim-searchindex'
" Macros
Plug 'christoomey/vim-titlecase'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" LaTeX
Plug 'lervag/vimtex'
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc'
" VimWiki
Plug 'vimwiki/vimwiki'
call plug#end()

" Enable colours
syntax on
if has('termguicolors')
	set termguicolors
endif
set background=dark

" Neovide config
if exists("g:neovide")
	set guifont=Fira\ Code:h15
	let g:neovide_hide_mouse_when_typing = v:true
endif

" Gruvbox
let g:gruvbox_invert_selection=0
let g:gruvbox_italic=1
if !has('nvim')
	let g:gruvbox_underline=0
	let g:gruvbox_undercurl=0
	let g:gruvbox_guisp_fallback='bg'
endif
colorscheme gruvbox
" Current line number
hi clear CursorLine
hi clear CursorLineNr
hi CursorLineNr guifg=#ebdbb2
" Search matches
hi CurSearch guibg=#b8bb26
hi CurSearch guifg=#282828
" TODOs
hi! link Todo GruvboxRed
" LaTeX
hi link texCMD GruvboxGreen
hi link texPartArgTitle GruvboxRed
" Verilog
hi link verilogOperator GruvboxBlue
hi link verilogConditional GruvboxYellow
hi link verilogLabel GruvboxOrange

" Lightline
let g:lightline = {'colorscheme':'gruvbox'}

" Tmuxline
let g:tmuxline_powerline_separators=0
let g:tmuxline_preset='minimal'

" Vim settings
set laststatus=2 " Status line
set nu rnu " Line numbers (relative)
set wrap " Wrap test
set linebreak " Wrap text at end of word
set cursorline " Change current line number colour
set autoindent " Auto indentation upon return
set mouse=a " Mouse enabled for all modes
set clipboard=unnamed " Copy and paste without '*'
set ts=4 sw=4 " 4 space tabs
set encoding=utf-8 " UTF-8 test encoding
set hlsearch " Highlight search matches
set noshowmode " Hide text displaying current mode
set scrolloff=8 " Leave at least 8 lines above or below cursor
set autoread " Auto-update file
set complete-=i " Change completion sources
set foldmethod=manual " Manual folds only
set wildmenu " Enhanced command-line completion
set spellsuggest+=10 " Number of spelling suggestions
" set ruler " Show line and column number

" Smoothscrolling and display wrapped text
set wrap smoothscroll
set display=lastline

" '\s' shows spelling suggestions
nnoremap \s ea<C-X><C-S>

" Vimtex
filetype plugin on
let g:vimtex_view_method = 'skim'
let g:vimtex_matchparen_enabled = 0

" Markdown
let g:markdown_fenced_languages = ['python', 'bash=sh']
let g:vmt_list_item_char="-"

" VimWiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_markdown_link_ext = 1

" Filetype
autocmd BufNewFile,BufRead *.v,*.vs set syntax=verilog
autocmd BufNewFile,BufRead *.pio set syntax=c
autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.md set spell
