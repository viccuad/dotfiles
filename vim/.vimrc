runtime! debian.vim " ensures that various options are properly set to work

" Usage {{{
" To use it, copy it to
" for Unix and OS/2: ~/.vimrc
" for Amiga: s:.vimrc
" for MS-DOS and Win32: $VIM\_vimrc
" for OpenVMS: sys$login:.vimrc
"
" this file has ordered commands for it to work. don't blindly change
" the order.
"
" }}}

" Lang {{{
" stackoverflow says it should be as up as possible, but it works anyways
language messages en_US.utf8
set langmenu=en_US.utf8
let $LANG = 'en_US.utf8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set spelllang=en,es
" }}}

" Vundle config {{{
" This should be on top
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
	"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
	"Plugin 'L9'
" Git plugin not hosted on GitHub
	"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
	"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
	"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
	"Plugin 'user/L9', {'name': 'newL9'}

" ADD YOUR PLUGINS HERE:
" Looks:
Plugin 'ScrollColors'						" scroll themes with :SCROLLCOLOR
Plugin 'Colour-Sampler-Pack'				" more color themes
Plugin 'chriskempson/base16-vim'			" base16 color themes
Plugin 'mimicpak'							" more color theme
Plugin 'severin-lemaignan/vim-minimap'		" sublime-text style minimap (NEEDS braille capable font, python)
Plugin 'yonchu/accelerated-smooth-scroll'	" smooth scroll on <C-d>, <C-u>, <C-f>, <C-b>
Plugin 'bling/vim-airline'					" status/tabline (NEEDS powerline font)

" Functionality:
Plugin 'matchit.zip'						" cicles between if, then, else..
Plugin 'tpope/vim-surround'					" surround strings faster 			(http://www.catonmat.net/blog/vim-plugins-surround-vim/)
Plugin 'scrooloose/nerdtree'				" navigation tree
Plugin 'tpope/vim-fugitive'					" git support
Plugin 'majutsushi/tagbar'					" show list of variables, functions, classes.. (NEEDS ctags)
"Plugin 'kien/ctrlp.vim'						" full path fuzzy file,buffer,mru,tag.. finder
"Plugin 'sjl/gundo.vim'						" visualize vim undo tree
"Plugin 'Valloric/YouCompleteMe'			" (NEEDS to be compiled, read the docs!)
Plugin 'airblade/vim-gitgutter'				" show +,-,~ git changes on the gutter
"Plugin 'nathanaelkane/vim-indent-guides'	" visually display indent levels
Plugin 'scrooloose/syntastic'				" automatic syntax checking
Plugin 'xolox/vim-misc'						" (NEEDED by vim-shell)
Plugin 'xolox/vim-shell'					" provides integration between Vim and environment (fullscreen, etc). requires wmctrl
Plugin 'scrooloose/nerdcommenter'			" toggle comments
Plugin 'Raimondi/delimitMate'				" provides insert mode auto-completion for quotes,parens,brackets..

" Filetype:
Plugin 'msanders/snipmate.vim'				" adds a lot of snippets with tab
Plugin 'godlygeek/tabular' 					" needed by vim-markdown
Plugin 'plasticboy/vim-markdown'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'vivien/vim-addon-linux-coding-style'
Plugin 'c.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

" Spaces & Tabs {{{
set tabstop=4					" number of visual spaces per TAB
set autoindent smartindent		" copy indent from current line when starting a new line, smartindent
set nolist						" don't show white separators, toggle :set list!
set listchars=tab:>·,trail:·	" but only show tabs and trailing whitespace
" }}}

" Line wrap {{{
" gq: performs 'rewrap the text'
set wrap					" soft wrap long lines, visually, instead of changing the file
"set linebreak				" wrap long lines at characters in 'breakat' rather than at the last character that fits
set breakindent				" wrapped lines are visually indented
set nolist  				" list disables linebreak
let &colorcolumn=join(range(81,200),",") " colors columns past 80
set textwidth=80
set formatoptions=tcrql 	" t autowrap to textwidth
							" c autowrap comments to textwidth
							" r autoinsert comment leader with <enter>
							" q allow formatting of comments with gq
							" l	Long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
							" 1	Don't break a line after a one-letter word. It's broken before it instead (if possible).
							" j	Where it makes sense, remove a comment leader when joining lines
" highilight everything past textwitdh:
let g:toggleHighlight = 1
function! ToggleHighlight(...)
	if a:0 == 1 "toggle behaviour
		let g:toggleHighlight = 1 - g:toggleHighlight
	endif
	if g:toggleHighlight == 0 "normal action, do the hi
		highlight OverLength ctermbg=darkgrey guibg=#592929
		match OverLength /\%80v.*/
	else
		call clearmatches()
	endif
endfunction
autocmd CursorMoved * call ToggleHighlight()
" }}}

" Filetype & languages {{{
filetype on						" Enable filetype detection
filetype indent on				" Enable filetype-specific indenting
filetype plugin on				" Enable filetype-specific plugins

" C language
let c_space_errors = 1
let c_comment_strings=1			" highlight strings inside C comments

" Python language
let python_space_errors = 1
au FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" Java language
let java_space_errors = 1
" }}}

" Look and feel {{{
set title						" change terminal title
syntax on						" enable syntax processing
set background=dark 			" if using a dark background, for syntax highlighting
set number						" show line numbers
set relativenumber				" show relative numbers. can be on at the same time that number
set cursorline					" highlight current line
set showcmd						" Show (partial) command in status line
set wildmenu        			" visual autocomplete for command menu
set showmatch					" Highlight matching brackets
set mouse=a						" Enable mouse usage (all modes)
set mousehide					" Hide the mouse when typing text
set backspace=indent,eol,start	" allow backspacing over all of that
set ruler 						" show the cursor position and line number at the bar
set lazyredraw					" don't redraw while in macros
set scrolloff=5					" keep at least 5 lines above/below
set sidescrolloff=5 			" keep at least 5 lines left/right
set noerrorbells				" no error bells please
set visualbell
set vb t_vb=					" no beep or flash
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb= 	"redo t_vb= for gui so it takes place
endif
set timeout			" time out on key codes
set ttimeoutlen=500	" The time in milliseconds that is waited for a key code or mapped key sequence to complete

let base16colorspace=256	" Access colors present in 256 colorspace
if has("gui_running")
	"colorscheme base16-colors
	set guiheadroom=0		" vim padding: fix it in ~/.gtkrc-2.0

	colorscheme xoria256
	highlight ColorColumn ctermbg=233 guibg=#121212 " colorcolumn for xoria256

	set guioptions-=T		" Remove Toolbar
	set guioptions+=c		" Use console dialogs
	set guioptions-=r		" Remove right-hand scrollbar
	set guioptions-=R		" Remove right-hand scrollbar
	set guioptions-=l		" Remove left-hand scrollbar
	set guioptions-=L		" Remove left-hand scrollbar

	if has("gui_gtk2")
		"set guifont=Monospace\ 10
		"set guifont=DejaVu\ Sans\ Mono\ 10
		"set guifont=Terminus\ 9
		set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 8
	elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
	set guifont=Consolas:h11:cANSI
	endif
else
	colorscheme xoria256
	highlight ColorColumn ctermbg=233 guibg=#121212 " colorcolumn for xoria256
endif
" }}}

" Plugins settings {{{
" Latex Box Plugin
let g:LatexBox_output_type="pdf"
let g:LatexBox_latexmk_async=1 					"allow latexmk to run in the background and load any compilation errors in a quickfix window after it finishes running.
"let g:LatexBox_latexmk_preview_continuously=1 	"Latexmk will track the currently edited file for writes and recompile automatically when necessary
let g:LatexBox_quickfix=3 						" recommended by preview_continously
let g:LatexBox_latexmk_options="-pdflatex='xelatex --shell-escape -interaction=nonstopmode %O %S' -cd -f"
let g:LatexBox_autojump=1						" auto jump to first error after compiling

" NERDTree Plugin
" Open NERDTree automatically on startup if no file is specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Airline
let g:airline_powerline_fonts = 1 						" automatically populate the g:airline_symbols dictionary with the powerline symbols
set laststatus=2 										" Always show statusline
"set showtabline=2 										" Always display the tabline, even if there is only one tab
set noshowmode 											" Hide the default mode text (e.g. -- INSERT -- below the statusline)
let g:airline#extensions#tabline#enabled = 1			" automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#left_sep = ' '			" straight separators
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_idx_mode = 1	" display numbers in the tab line, and use mappings \1 to \9

" Accelerated smooth scroll
let g:ac_smooth_scroll_du_sleep_time_msec = 5
let g:ac_smooth_scroll_fb_sleep_time_msec = 5


" Gitgutter
highlight clear SignColumn		" needs to be after your colorscheme

" YouCompleteMe
"let g:ycm_auto_trigger = 0		" turn off the as-you-type popup and the popup you'd get after typing . or -> in say C++. You can still use it by <C-Space> shortcut.

" vim-shell
let g:shell_fullscreen_items = ''		"hide: m mainmenu, T toolbar, e tabline

" }}}

" Persistence {{{
set viminfo+=% "save and restore the buffer list expect if vim is started with a file name argument
set viminfo+=n$HOME/.vim/.viminfo
" delete the empty buffer that appears on startup:
autocmd VimEnter * nested if  bufname('')==''  &&  line('$') == 1 &&  col('$')==1 &&  !&modified | bd % | endif

set hidden					" don't mark buffers as abandoned if hidden
set history=1000
set undofile				" Save undo's after file closes
set undodir=$HOME/.vim/undo	" where to save undo histories
set undolevels=1000			" How many undos
set undoreload=10000		" number of lines to save for undo
" }}}

" Backup and Swap files {{{
"set bdir-=.					" to make vim use other folders for backup files, (/tmp for example)
"set bdir+=$HOME/.vim/backup
"set dir-=.						" to make vim stop using current folder for .swp files
"set dir+=$HOME/.vim/backup
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup
" }}}

" Searching {{{
set ignorecase		" Do case insensitive matching
set smartcase		" Overrides ignorecase if uppercase used in search string
set incsearch		" Incremental search
set hlsearch		" highlight matches
set wrapscan		" jumps to the beginning if reaching end, and viceversa
" }}}

" Mappings {{{
" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
" Can be typed even faster than jj
inoremap jk <Esc>

" force yourself to stop using the arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" move between tabs
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nnoremap  <C-w> :qall<CR> 				" close window

" list of shared binds:
map <silent> <F2> :write<CR>						" write file without confirmation
"nnoremap <silent> <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let"@/=_s<Bar>:nohl<CR> " remove trailing whitespaces
map <F3> :%s/\s\+$//<CR>							" remove trailing whitespaces
map <silent> <F4> <Esc>:bd<CR>						" close buffer 
map <F5> :setlocal spell!<CR>						" toggle spell checking
"   <F6>											" open (from vim-shell)
"map <F7> :%!astyle --style=linux --indent=tab=8		" apply Linux C style (NEEDS astyle installed)
"map <F8> :call ToggleHighlight(1)<CR>				" highlight all past 80 chars
map  <silent> <F7>    <Esc>:cprevious<CR>			" previous c error
map  <silent> <F8>    <Esc>:cnext<CR>				" next c error
" <F9>												" compile & link c code (alt+<F9> write + compile)
" <F11> 											" fullscreen (from vim-shell)
" }}}

" Folding {{{
set foldmethod=marker		" fold based on marker level
set foldnestmax=10			" max 10 depth
set nofoldenable			" don't fold files by default on open
set foldlevelstart=1		" start with fold level of 1
" }}}

" Launch {{{
set encoding=utf8
set autowrite								" Automatically save before commands like :next and :make
set autochdir								" automatically cd into the directory that the file is in (this will break plugins if activated!!!)
"autocmd BufEnter * silent! lcd %:p:h		" automatically cd into the dir of the file. this breaks less
set autoread								" watch for file changes
set modeline								" make vim check beginning and ending lines of files for options
" jump to the last position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

" Reload configs {{{
" reload configs at save
augroup myvimrc
	au!
	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
augroup END
" }}}

" TODO
" http://zzapper.co.uk/vimtips.html
" sublime text multiple cursors
" remapear :
" tmux con colores falla
" wrap bien

" vim:foldmethod=marker:foldlevel=0
