" this file has ordered commands for it to work. don't blindly change the order.

" this is a minimal vimrc, to be used with vim in secure mode: no .vimrc and no plugins

" Lang {{{
language messages en_US.utf8
set langmenu=en_US.utf8
let $LANG = 'en_US.utf8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set spelllang=en,es
" }}}

" Filetype & languages {{{
filetype on						" enable filetype detection
filetype indent on				" enable filetype-specific indenting. can conflict with set autoindent smartindent
filetype plugin on				" enable filetype-specific plugins

" C language
let g:c_space_errors = 1
let g:c_comment_strings = 0		" dont highlight strings inside C comments

" Python language
let python_space_errors = 1
augroup python_files
	autocmd!
	autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
augroup END

" Java language
let java_space_errors = 1

" Markdown instead of modula2:
let g:markdown_fenced_languages = ['asm', 'sh', 'bash=sh', 'c', 'python', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']
augroup markdown_files
	autocmd!
	autocmd BufNewFile,BufReadPost *.md setl filetype=markdown spell wrap nolinebreak nolist formatoptions-=t
augroup END

" TXT files
augroup txt_files
	autocmd!
	autocmd BufNewFile,BufReadPost *.txt setl spell textwidth=80 wrapmargin=80
augroup END

" Mail files from mutt
augroup mail_files
	autocmd!
	autocmd FileType mail setl nonumber spell textwidth=72 wrapmargin=72
augroup END
" }}}

" Spaces & Tabs {{{
set tabstop=4						" number of visual spaces per TAB
set autoindent smartindent			" copy indent from current line when starting a new line, and smart indent automatically inserts one level of indentation in some cases.
" set listchars=tab:\|·,trail:·,eol:¬	" show tabs, eol and trailing whitespace when showing separators
" set listchars=tab:\├\─,trail:·,eol:↵,extends:→,precedes:←	" show tabs, eol and trailing whitespace when showing separators
set listchars=tab:\╶\─,trail:·,eol:↵,extends:→,precedes:←	" show tabs, eol and trailing whitespace when showing separators
" set listchars=tab:▸\ ,trail:·,eol:↵,extends:→,precedes:←	" show tabs, eol and trailing whitespace when showing separators
set list							" show listchars
" }}}

" Line wrap {{{
" gq: performs 'rewrap the text'
set wrap							" soft wrap long lines, visually, instead of changing the file
set linebreak						" wrap long lines at characters in 'breakat' rather than at the last character that fits
set breakindent						" wrapped lines are visually indented
let &colorcolumn=join(range(73,220),",") " colors columns past 80
set textwidth=80
set formatoptions=tcrqljw 			" t autowrap to textwidth
									" c autowrap comments to textwidth
									" r autoinsert comment leader with <enter>
									" q allow formatting of comments with gq
									" l long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
									" 1 don't break a line after a one-letter word. It's broken before it instead (if possible).
									" j where it makes sense, remove a comment leader when joining lines
									" a automatic formatting of paragraphs
									" w trailing white space indicates a paragraph continues in the next line
" }}}

" Look and feel {{{
set title							" change terminal title
syntax on							" enable syntax processing
"set virtualedit=all				" move the cursor everywhere
set synmaxcol=2048					" prevents huge slow downs from syntax highlighting
set number							" show line numbers
"set relativenumber					" show relative numbers. can be on at the same time that number
set cursorline						" highlight current line
set conceallevel=2					" display unicode characters instead of they plaintext counterparts (epsilon, lambda, etc)
" don't change colors of concealed characters:
highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set showcmd							" show (partial) command in status line
set wildmenu        				" visual autocomplete for command menu
set wildmode=longest,list,full		" complete longest common string, then list alternatives, then select the sortest first
set cpoptions+=$					" put a '$' at the end of the changed text
set showmatch						" highlight matching brackets
set mouse=a							" enable mouse usage (all modes)
set mousehide						" hide the mouse when typing text
set backspace=indent,eol,start		" allow backspacing over all of that
set ruler 							" show the cursor position and line number at the bar
set lazyredraw						" don't redraw while in macros
set scrolloff=5						" keep at least 5 lines above/below
set sidescrolloff=5 				" keep at least 5 lines left/right
set splitright 						" vertical splits use right half of screen
set splitbelow 						" horizontal splits use bottom half of screen
set noerrorbells					" no sound bells please
set visualbell t_vb=				" no flash screen for the visual bell
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb= 	"redo t_vb= for gui so it takes place
endif
set timeout							" time out on key codes
set ttimeoutlen=20					" the time in milliseconds that is waited for a key code or mapped key sequence to complete

if has("gui_running")
	set guiheadroom=0				" vim padding: fix it in ~/.gtkrc-2.0
	set background=dark 			" if using a dark background, for syntax highlighting

	colorscheme base16-monokai
	set guioptions-=T				" remove Toolbar
	set guioptions+=c				" use console dialogs
	set guioptions-=r				" remove right-hand scrollbar
	set guioptions-=R				" remove right-hand scrollbar
	set guioptions-=l				" remove left-hand scrollbar
	set guioptions-=L				" remove left-hand scrollbar

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
	" set t_Co=256					" force number of colors to 256 inside vim. this shouldn't be done, better with TERM
	set background=dark 			" if using a dark background, for syntax highlighting
	" colorscheme badwolf
	" colorscheme wombat256
	" colorscheme wombat256mod
	colorscheme xoria256
	" colorscheme base16-default
	" colorscheme base16-tomorrow
	"let base16colorspace=256		" access colors present in 256 colorspace
	" colorscheme gruvbox
	" highlight ColorColumn ctermbg=232 guibg=#080808		" colorcolumn for badwolf
	" highlight ColorColumn ctermbg=0 guibg=#000000 	" colorcolumn for wombat256
	" highlight ColorColumn ctermbg=232 guibg=#080808 	" colorcolumn for wombat256mod
	highlight ColorColumn ctermbg=233 guibg=#121212	" colorcolumn for xoria256
	" highlight ColorColumn ctermbg=235 guibg=#262626	" colorcolumn for base16-default
	" highlight ColorColumn ctermbg=0 guibg=#303030		" colorcolumn for base16
endif

" colorscheme settings I want to be there even if I change themes:
highlight Comment cterm=italic gui=italic	" put comments in italic (needs to be after your colorscheme) (needs tmux to be correctly set)
highlight clear SignColumn					" sets the git gutter to the same color as the number column (needs to be after your colorscheme)

set isfname+=32										"netrw: to open files with spaces
" }}}

" Persistence {{{
" set viminfo+=% "save and restore the buffer list expected if vim is started with a file name argument
" set viminfo+=n$HOME/.vim/.viminfo
" delete the empty buffer that appears on startup:
"autocmd VimEnter * nested if  bufname('')==''  &&  line('$') == 1 &&  col('$')==1 &&  !&modified | bd % | endif

set hidden							" don't mark buffers as abandoned if hidden
set undolevels=-1					" deactivate undo and history
" }}}

" Backup and Swap files {{{
set nobackup
set nowritebackup
" }}}

" Searching {{{
set ignorecase						" do case insensitive matching
set smartcase						" overrides ignorecase if uppercase used in search string
set incsearch						" incremental search
set hlsearch						" highlight matches
set wrapscan						" jumps to the beginning if reaching end, and viceversa
" }}}

" Mappings {{{
" make these commonly mistyped commands still work:
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

let mapleader = "\<Space>"

" use tab key to cycle through the buffers:
" if has('nvim')
" 	nnoremap <C-Tab>   :bnext<CR>
" 	nnoremap <C-S-Tab> :bprevious<CR>
" else
	nnoremap <leader><Tab>   :bnext<CR>
	nnoremap <leader><S-Tab> :bprevious<CR>
" endif

" remap jk to escape:  You'll never type it anyway, so it's great!
inoremap jk <Esc>

" use hjkl-movement between rows when soft wrapping:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" include the default behaviour by doing reverse mappings so you can move linewise with gj and gk:
nnoremap gj j
nnoremap gk k

" keep the cursor in place when joining lines with J (by dropping a mark and returning there):
nnoremap J mzJ`z

" Y yanks lines from the cursor to the end of the line: (as said in :h Y)
map Y y$

" force yourself to stop using the arrow keys:
map <up>    <nop>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>

" list of shared binds:
" remove trailing whitespaces:
map <F1> :%s/\s\+$//<CR>

" toggle spell checking:
map <F2> :setlocal spell!<CR>

" close buffer:
map <silent> <F4> <Esc>:bd<CR>

" open urls, files, etc. example: http://google.com:
noremap <F6> :!xdg-open <cfile><CR><CR>

" }}}

" Folding {{{
set foldmethod=syntax
set foldlevel=99
set foldnestmax=10			" max 10 depth
set nofoldenable			" don't fold files by default on open
set foldlevelstart=1		" start with fold level of 1
" }}}

" Launch {{{
set encoding=utf-8
set autowrite								" automatically save before commands like :next and :make
set autochdir								" automatically cd into the directory that the file is in (this will break plugins if activated!!!)
"autocmd BufEnter * silent! lcd %:p:h		" automatically cd into the dir of the file. this breaks less
set autoread								" watch for file changes
set nomodeline								" dont make vim check beginning and ending lines of files for options. HUGE VULNERABILITY
" jump to the last position when reopening a file:
if has("autocmd")
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
