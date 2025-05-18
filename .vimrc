call plug#begin()
Plug 'tpope/vim-commentary'  " Comments (gc)
Plug 'christoomey/vim-titlecase'  " Titlecase (gz)
Plug 'tpope/vim-surround'  " Parentheses, brackets, quotes (cs,ds,ys)
Plug 'christoomey/vim-tmux-navigator'  " Tmux pane switching
Plug 'bullets-vim/bullets.vim'  " Lists
Plug 'lervag/vimtex'  " LaTex
Plug 'preservim/nerdtree'  " Tree explorer
Plug 'itchyny/lightline.vim'  " Status line
Plug 'edkolev/tmuxline.vim'  " Status line (tmux)
Plug 'gruvbox-community/gruvbox'  " Gruvbox colourscheme
call plug#end()

" MIGHT REINSTALL ¯\_(ツ)_/¯
" Plug 'godlygeek/tabular'
" Plug 'preservim/vim-markdown'
" Plug 'mzlogin/vim-markdown-toc'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'vimwiki/vimwiki'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}


""" PLUGIN CONFIG

filetype plugin on  " Enable filetype-based plugin scripts

" Enable colours
syntax on
if has('termguicolors')
	set termguicolors
endif
set background=dark

" Gruvbox
let g:gruvbox_invert_selection=1
let g:gruvbox_italic=1
silent! colorscheme gruvbox

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
let lightline#colorscheme#gruvbox#palette['tabline']['tabsel'] = [lightline#colorscheme#gruvbox#palette['normal']['right'][0]]
let lightline#colorscheme#gruvbox#palette['tabline']['left'] = [lightline#colorscheme#gruvbox#palette['normal']['right'][1]]
let lightline#colorscheme#gruvbox#palette['tabline']['middle'] = lightline#colorscheme#gruvbox#palette['normal']['middle']
let lightline#colorscheme#gruvbox#palette['tabline']['right'] = lightline#colorscheme#gruvbox#palette['normal']['middle']

" Tmuxline
let g:tmuxline_powerline_separators=0
let g:tmuxline_preset='minimal'

" Vimtex
let g:vimtex_view_method = 'skim'  " Use Skim as LaTex .pdf viewer
let g:vimtex_matchparen_enabled=0  " Environment detection as reducing performance
let g:vimtex_fold_enabled=0  " Disabling folding (MIGHT CHANGE ¯\_(ツ)_/¯)

" Bullets
let g:bullets_outline_levels = ['num', 'abc', 'rom', 'std*']
let g:bullets_enabled_file_types = ['markdown', 'text', 'tex']


""" (N)VIM CONFIG

" Appearance
set nu rnu  " Enable relative line numbers
set cursorline  " Highlight current line
set laststatus=2  " Enable status line
set noshowmode  " Display mode in status line
set ruler  " Show line and column number (not needed with lightline)

" Behaviour
set mouse=a  " Enable mouse for all modes
set clipboard=unnamed  " Copy and paste to system clipboard without '*'
set nowrap  " Don't wrap text
set hlsearch  " Highlight all search matches
set shortmess-=S  " Display number of search matches
set scrolloff=5  " Leave at least 5 lines above or below cursor
set autoindent  " Auto indentation after return
set complete-=i  " Do not complete using files specified in the 'include' option
set wildmenu  " Enhanced command-line completion
set autoread  " Auto-update files
set nohidden  " Do not hide buffers in background
" set foldmethod=manual  " Manual folds only (MIGHT CHANGE ¯\_(ツ)_/¯)
" set completeopt-=preview (MIGHT CHANGE ¯\_(ツ)_/¯)

" Common sense
set encoding=utf-8  " UTF-8 text encoding
set ts=4 sw=4  " 4 space tabs

" Files containing prose
function! ProseConfig()
	" Spelling
	setlocal spell  " Enable spell checking
	setlocal spellsuggest+=5  " Maximum number of spelling suggestions
	" '\s' shows spelling suggestions
	nnoremap \s ea<C-X><C-S>

	" Line wrapping
	setlocal wrap  " Enable line wrapping
	setlocal linebreak " Wrap text at end of words
	setlocal smoothscroll  " Single line scrolling
	setlocal display=lastline  " Don't hide lines cut off by window
endfunction

" Tex files
function! LatexConfig()
	nnoremap <buffer> \ia :read $DOTFILES/latex/article_template.tex<CR>kdd/maketitle<CR>:noh<CR>2j
	nnoremap <buffer> \ip :read $DOTFILES/latex/presentation_template.tex<CR>kdd/{frame}{}<CR>:noh<CR>j
endfunction
augroup LatexAutocmds
	autocmd!
	autocmd FileType tex call LatexConfig() | call ProseConfig()
augroup END

" Markdown files
function! MarkdownConfig()
	" Pandoc .md --> .pdf
	nnoremap \m :!pandoc %:p -o $(basename %:p .md).pdf -V geometry:"left=25mm, right=25mm, top=25mm, bottom=25mm" -V papersize:a4 -V fontsize:11pt -V boxlinks:true -V header-includes:"\renewcommand{\familydefault}{\sfdefault}"<CR> <CR>
	" :redraw! echo "Successfully converted % to pdf"  " MIGHT FIX ¯\_(ツ)_/¯
	nnoremap \o :!open $(basename %:p .md).pdf<CR> <CR>

	" Syntax highlighting for code blocks
	let g:markdown_fenced_languages = ['python', 'bash=sh']

	" Syntax highlighting for nested lists indented by 8 spaces
	syn clear markdownListMarker
	syn match markdownListMarker "\%(\t\| \{0,8\}\)[-*+]\%(\s\+\S\)\@=" contained
	syn clear markdownOrderedListMarker
	syn match markdownOrderedListMarker "\%(\t\| \{0,8}\)\<\d\+\.\%(\s\+\S\)\@=" contained

	" Syntax highlighting for LaTex maths environments
	unlet b:current_syntax
	syn include @tex syntax/tex.vim
	let b:current_syntax = 'markdown'
	syn region markdownMath start="\\\@<!\$" end="\$" skip="\\\$" contains=@tex keepend
	syn region markdownMath start="\\\@<!\$\$" end="\$\$" skip="\\\$" contains=@tex keepend
endfunction
augroup MarkdownAutocmds
	autocmd!
	autocmd FileType markdown call MarkdownConfig() | call ProseConfig()
augroup END

" Fix incorrect syntax highlighting
autocmd BufNewFile,BufRead *.v,*.vs set syntax=verilog
autocmd BufNewFile,BufRead *.pio set syntax=c


""" TERMINAL CONFIG

" Neovide
if exists("g:neovide")
	" Font settings
	set guifont=Fira\ Code:h15
	set linespace=2

	" Cursor settings
	let g:neovide_cursor_animation_length=0.00
	let g:neovide_cursor_trail_size=0
" Terminal
else
	set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
	\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
	\,sm:block-blinkwait175-blinkoff150-blinkon175
endif


""" DEPRECATED

" if has('nvim')
" 	Plug 'lifepillar/vim-solarized8', { 'branch': 'neovim' }  " Nvim solarized
" else
" 	Plug 'lifepillar/vim-solarized8'  " Vim solarized
" endif

" " Solarized8
" syntax on  " Enable syntax highlighting
" set background=light  " Light mode
" if has('nvim')
" 	let g:solarized_t_Co=16  " 16 colour neovim
" else
" 	set t_Co=16  " 16 colour vim
" endif
" let g:solarized_termcolors = 16  " 16 colour solarized
" silent! colorscheme solarized8
" hi clear Cursearch | hi link CurSearch IncSearch  " Cursor search match

" " Lightline
" let g:lightline = {'colorscheme':'solarized'}
