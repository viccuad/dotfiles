" this file has ordered commands for it to work. don't blindly change the order.

" Lang {{{
language messages en_US.utf8
set langmenu=en_US.utf8
let $LANG = 'en_US.utf8'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set spelllang=en,es
" }}}

" Vim-Plug Config {{{
" Automatic installation:
if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall
endif

" For Mac/Linux users
call plug#begin('~/.vim/bundle')
" For Windows users
" call plug#begin('~/vimfiles/bundle')

" ADD YOUR PLUGINS HERE:

" LOOKS:
"Plug 'ScrollColors'								" scroll themes with :SCROLLCOLOR
"Plug 'mimicpak'									" more color themes
Plug 'chriskempson/base16-vim'						" base16 color themes
Plug 'morhetz/gruvbox'
	let g:gruvbox_bold=1
	let g:gruvbox_italic=1
	let g:gruvbox_underline=1
	let g:gruvbox_undercurl=1
	let g:gruvbox_termcolors=256
	let g:gruvbox_contrast_dark="hard"
	let g:gruvbox_contrast_light="hard"
	" let g:gruvbox_hls_cursor="orange"
	let g:gruvbox_sign_column="dark0"
	let g:gruvbox_color_column="dark0"
	let g:gruvbox_vert_split="dark0"
	let g:gruvbox_italicize_comments=1
	let g:gruvbox_italicize_strings=1
	let g:gruvbox_invert_selection=0
	let g:gruvbox_invert_signs=0
	let g:gruvbox_invert_indent_guides=0
	let g:gruvbox_invert_tabline=0
	let g:gruvbox_improved_warnings=1

Plug 'junegunn/goyo.vim', {'on': 'Goyo'}			" distraction free mode
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}	" hyperfocus mode
	let g:limelight_paragraph_span = 0
	function! s:goyo_enter()
		if has('gui_running')
			set fullscreen
			set linespace=7
		elseif exists('$TMUX')
			silent !tmux set status off
		endif
		" hi NonText ctermfg=101
		Limelight
	endfunction
	function! s:goyo_leave()
		if has('gui_running')
			set nofullscreen
			set linespace=0
		elseif exists('$TMUX')
			silent !tmux set status on
		endif
		Limelight!
	endfunction
	augroup goyo_plus_limeligh
		autocmd!
		autocmd! User GoyoEnter
		autocmd! User GoyoLeave
		autocmd  User GoyoEnter nested call <SID>goyo_enter()
		autocmd  User GoyoLeave nested call <SID>goyo_leave()
	augroup END

" Plug 'zefei/vim-colortuner', {'on': 'Colorturner'}			" saturation, hue, etc tuning (only works with true colours: neovim, gvim)
	let g:colortuner_filepath = '~/.vim/.vim-colortuner'

Plug 'bling/vim-airline'							" status/tabline (NEEDS powerline font)
	let g:airline_powerline_fonts = 1 						" automatically populate the g:airline_symbols dictionary with the powerline symbols
	set laststatus=2 										" always show statusline
	set noshowmode 											" hide the default mode text (e.g. -- INSERT -- below the statusline)
	let g:airline#extensions#tabline#enabled = 1			" automatically displays all buffers when there's only one tab open
	"let g:airline#extensions#tabline#left_sep = ' '		" straight separators
	"let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline#extensions#tabline#buffer_idx_mode = 1	" display numbers in the tab line, and use mappings <leader>1 to <leader>9
	let g:airline#extensions#tmuxline#enabled = 0
	let g:airline#extensions#tagbar#enabled = 0
	let g:airline_theme_patch_func = 'AirlineThemePatch'
	function! AirlineThemePatch(palette)
			if g:airline_theme == 'badwolf'
					let a:palette.normal.airline_c = [ '#8cffba' , '#242321' , 121 , 233 ]
					let a:palette.insert.airline_c = [ '#0a9dff' , '#242321' , 39  , 233 ]
			elseif g:airline_theme == 'gruvbox'
					let a:palette.normal.airline_c = [ '#8cffba' , '#1C1C1C' , 121 , 234 ]
			endif
	endfunction

" Plug 'edkolev/tmuxline.vim'							" clone airline to tmux (its set up, only uncomment if you want to change the tmux statusline theme again)
	" To export current statusline to a file which can be sourced by tmux.conf on startup:
	" :TmuxlineSnapshot! ~/.tmux/tmuxline
	"let g:tmuxline_powerline_separators = 0		" use block separators instead
	let g:tmuxline_preset = {
		\'a'    : '#S',
		\'b'    : '#W',
		\'win'  : '#I #W',
		\'cwin' : '#I #W',
		\'y'    : '%R',
		\'z'    : '#H #(rainbarf --width 10 --bolt --remaining --rgb)'}

Plug 'sjl/badwolf'									" badwolf color theme
	let g:badwolf_darkgutter = 1					" make the gutters darker than the background.
	let g:badwolf_tabline = 1 						" make the tabline the same color as the background


" FUNCTIONALITY:
Plug 'matchit.zip'									" cicles between if, then, else..
Plug 'tpope/vim-surround'							" surround strings faster (csXX, dsX, ysMX, yssX)
Plug 'tpope/vim-speeddating'						" fixes vim incrementing of dates, times, etc (<C-A>, <C-X>)
" Plug 'tpope/vim-vinegar'							" enhances the netrw split file explorer
" Plug 'tpope/vim-fugitive'							" git support
" Plug 'airblade/vim-gitgutter'						" show +,-,~ git changes on the gutter
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}	" show list of variables, functions, classes.. (NEEDS exuberant-ctags)
"Plug 'kien/ctrlp.vim'								" full path fuzzy file,buffer,mru,tag.. finder
Plug 'scrooloose/syntastic'							" automatic syntax checking
Plug 'LargeFile'									" disables certain features of vim for speed in large files
Plug 'AndrewRadev/inline_edit.vim', {'on': 'InlineEdit'}	" change code inside other code with ':InlineEdit'
Plug 'tpope/vim-commentary'							" comment with motion support
Plug 'tmux-plugins/vim-tmux-focus-events'			" let terminal vim to know about focus changes (autoread, etc)
Plug 'junegunn/vim-peekaboo'						" shows the contents of the registers on pop-up buffer
"Plug 'tasklist.vim'								" <leader> t shows a list of TODOs and FIXMEs
Plug 'christoomey/vim-tmux-navigator'				" seamlessly navigate between tmux and vim panels
" Plug 'utl.vim'									" universal Text Linking: execute URLs, footnotes, open emails, organize
" Plug 'jceb/vim-orgmode'							" emacs org-mode in vim (needs utl.vim for links)
" Plug 'kshenoy/vim-signature'						" place, toggle and display marks
Plug 'reedes/vim-wordy', {'on': 'NextWordy'}		" adds dictionaries for uncovering usage problems in your writing
Plug 'Keithbsmiley/investigate.vim'					" search the language docs with gK
" Plug 'drawit'										" to draw lines and diagrams (<leader>di to start, <leader>ds to stop)

Plug 'mhinz/vim-signify'							" show +,-,~ git changes on the gutter
	let g:signify_vcs_list = ['git']
	let g:signify_sign_change = '~'

Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}			" visualize vim undo tree
	let g:gundo_auto_preview = 0
	let g:gundo_preview_bottom = 1
	let g:gundo_width = 30

Plug 'yonchu/accelerated-smooth-scroll'				" smooth scroll on <C-d>, <C-u>, <C-f>, <C-b>
	let g:ac_smooth_scroll_du_sleep_time_msec = 5
	let g:ac_smooth_scroll_fb_sleep_time_msec = 5

Plug 'mhinz/vim-startify'							" a start screen with recently modified files and vim sessions
	let g:startify_session_persistence = 0			" automatically update sessions
	let g:startify_session_delete_buffers = 1		" delete open buffers before loading a new session
	let g:startify_custom_footer = [
		\ '',
		\ '    b   ➤ open in new buffer  :SLoad   ➤ load a session     ',
		\ '    s,v ➤ open in split       :SSave   ➤ save a session     ',
		\ '    t   ➤ open in tab         :SDelete ➤ delete a session   ',
		\ '',
		\ ]
	let g:startify_custom_header =
		\ map(split(system('fortune'), '\n'), '"   ". v:val') + ['']

Plug 'vim-scripts/Conque-GDB', {'on': 'ConqueGDB'}	" GDB integration inside vim
	let g:ConqueTerm_Color = 2						" 1: strip color after 200 lines, 2: always with color
	let g:ConqueTerm_CloseOnEnd = 1 				" close conque when program ends running
	let g:ConqueTerm_StartMessages = 0				" display warning messages if conqueTerm is configured incorrectly

Plug 'jez/vim-superman'								" wrapper around man.vim's Man command
	noremap K :SuperMan <cword><CR>


" COMPLETION AND SNIPPETS:
Plug 'Raimondi/delimitMate'							" provides insert mode auto-completion for quotes,parens,brackets..
Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}		" (NEEDS to be compiled, read the docs!)
	"let g:ycm_auto_trigger = 0		" turn off the as-you-type popup and the popup you'd get after typing . or -> in say C++. You can still use it by <C-Space> shortcut.
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

Plug 'SirVer/ultisnips'								" compatible with YouCompleteMe, this is the snippets engine
Plug 'honza/vim-snippets'							" Snippets are separated from the engine.
	let g:UltiSnipsEnableSnipMate = 0 " don't look for SnipMate snippets, in the 'snippets' dir
	let g:UltiSnipsSnippetDirectories=["snippets_UltiSnips"]
	" Ultisnips and YouCompleteMe integration, both work with tab
	function! g:UltiSnips_Complete()
		call UltiSnips#ExpandSnippet()
		if g:ulti_expand_res == 0
			if pumvisible()
				return "\<C-n>"
			else
				call UltiSnips#JumpForwards()
				if g:ulti_jump_forwards_res == 0
					return "\<TAB>"
				endif
			endif
		endif
		return ""
	endfunction
	au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsListSnippets="<c-e>"
	" this maps Enter key to <C-y> to chose the current highlight item
	" and close the selection list, same as other IDEs:
	" CONFLICTS with some plugins like tpope/Endwise
	inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" FILETYPE:
Plug 'freitass/todo.txt-vim', {'for': 'todo'}		" for todo.txt filetypes
" Plug 'rust-lang/rust.vim'
" Plug 'pangloss/vim-javascript'

Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'tex'}
	let g:LatexBox_output_type="pdf"
	let g:LatexBox_latexmk_async=1 					" allow Latexmk to run in the background and load any compilation errors in a quickfix window after it finishes running.
	"let g:LatexBox_latexmk_preview_continuously=1 	" Latexmk will track the currently edited file for writes and recompile automatically when necessary
	let g:LatexBox_quickfix=3 						" recommended by preview_continously
	let g:LatexBox_latexmk_options="-pdflatex='xelatex --shell-escape -interaction=nonstopmode %O %S' -cd -f"
	let g:LatexBox_autojump=1						" auto jump to first error after compiling

Plug 'justinmk/vim-syntax-extra', {'for': 'c'}		" bison, flex, c syntax (operators, delimiters, functions..)
Plug 'vivien/vim-addon-linux-coding-style', {'for': 'c'}
Plug 'c.vim', {'for': 'c'}
	let g:C_LocalTemplateFile = $HOME.'/.vim/snippets_Cvim/c-support/templates/Templates' " this allows for the templates to be versioned on .dotfiles

Plug 'hdima/python-syntax', {'for': 'python'}		" neccesary, vim default python syntax has a regex bug as of 7.4.663
	let python_highlight_all = 1
	" you can change between py v2 and v3 with :Python2Syntax and :Python3Syntax

Plug 'jamessan/vim-gnupg'							" encrypts/decrypts with gpg files that end in .gpg,.pgp or .asc. plaintext only on ram
	let g:GPGDefaultRecipients = ["0x5702AA3A <me@viccuad.me>"]
	let g:GPGUsePipes=1			" (might break the prompt) use pipes instead of vim /temp files (no writing to disk)

Plug 'Shougo/vinarise.vim', {'on': 'Vinarise'}		" hexadecimal editor

Plug 'sudar/vim-arduino-syntax', {'for': 'arduino'}
Plug 'jplaut/vim-arduino-ino', {'for': 'arduino'}	" provides ino calls (Needs inotool, picocom)
    " <Leader>ac - Compile the current sketch
    " <Leader>ad - Compile and deploy the current sketch
    " <Leader>as - Open a serial port in screen

Plug 'kana/vim-textobj-user'						" create your own text objects without pain
Plug 'reedes/vim-textobj-quote'						" put ‘typographic quotes’ instead of 'straight quotes' (needs vim-textobject-user)
	augroup textobj_quote
		autocmd!
		autocmd FileType markdown call textobj#quote#init()
		autocmd FileType textile call textobj#quote#init()
		autocmd FileType text call textobj#quote#init({'educate': 0})
	augroup END

call plug#end()
" }}}

" Filetype & languages {{{
filetype on						" enable filetype detection
filetype indent on				" enable filetype-specific indenting. can conflict with set autoindent smartindent
filetype plugin on				" enable filetype-specific plugins

" C language
let c_space_errors = 1
let c_comment_strings = 0		" dont highlight strings inside C comments

" Python language
let python_space_errors = 1
augroup python_files
	autocmd!
	autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
augroup END

" Java language
let java_space_errors = 1

" Markdown instead of modula2:
augroup markdown_files
	autocmd!
	autocmd BufNewFile,BufReadPost *.md setl filetype=markdown spell textwidth=0 wrapmargin=0
augroup END

" TXT files
augroup txt_files
	autocmd!
	autocmd BufNewFile,BufReadPost *.txt setl spell textwidth=0 wrapmargin=0
augroup END

" Mail files from mutt
augroup mail_files
	autocmd!
	autocmd FileType mail setl nonumber spell textwidth=0 wrapmargin=0
augroup END
" }}}

" Spaces & Tabs {{{
set tabstop=4						" number of visual spaces per TAB
" set autoindent smartindent		" copy indent from current line when starting a new line, and smart indent automatically inserts one level of indentation in some cases.
set listchars=tab:\|·,trail:·,eol:¬	" show tabs, eol and trailing whitespace when showing separators
"set listchars=tab:\ \ ,trail:·		" only show trailing whitespace when showing separators. the tab is 2 spaces
"set list							" show listchars
" }}}

" Line wrap {{{
" gq: performs 'rewrap the text'
set wrap							" soft wrap long lines, visually, instead of changing the file
set linebreak						" wrap long lines at characters in 'breakat' rather than at the last character that fits
set breakindent						" wrapped lines are visually indented
let &colorcolumn=join(range(81,200),",") " colors columns past 80
set textwidth=80
set formatoptions=tcrql 			" t autowrap to textwidth
									" c autowrap comments to textwidth
									" r autoinsert comment leader with <enter>
									" q allow formatting of comments with gq
									" l	Long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
									" 1	Don't break a line after a one-letter word. It's broken before it instead (if possible).
									" j	Where it makes sense, remove a comment leader when joining lines
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
set noerrorbells					" no error bells please
set visualbell t_vb=				" no beep or flash
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb= 	"redo t_vb= for gui so it takes place
endif
set timeout							" time out on key codes
set ttimeoutlen=500					" the time in milliseconds that is waited for a key code or mapped key sequence to complete

if has("gui_running")
	set guiheadroom=0				" vim padding: fix it in ~/.gtkrc-2.0
	set background=dark 			" if using a dark background, for syntax highlighting

	colorscheme base16-monokai
	let g:airline_theme= "base16"

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
	set t_Co=256					" force number of colors to 256 inside vim. this shouldn't be done, better with TERM
	set background=dark 			" if using a dark background, for syntax highlighting
	" colorscheme wombat256
	" colorscheme wombat256mod
	" colorscheme xoria256
	" colorscheme base16-default
	" colorscheme base16-tomorrow
	" let base16colorspace=256		" access colors present in 256 colorspace
	" colorscheme base16-flat
	" colorscheme gruvbox
	colorscheme badwolf
	if g:colors_name == "badwolf"
		let g:airline_theme= "badwolf"
		" fix sign column:
		highlight SignColumn ctermbg=232 guibg=#080808		" SignColumn for badwolf
		highlight SignifySignAdd ctermfg=154 guifg=#aeee00 ctermbg=232 guibg=#080808
		highlight SignifySignChange ctermfg=214 guifg=#ffa724 ctermbg=232 guibg=#080808
		highlight SignifySignDelete ctermfg=196 guifg=#ff2c4b ctermbg=232 guibg=#080808
		" change color column:
		highlight ColorColumn ctermbg=233 guibg=#121212		" ColorColumn for badwolf
		" change vertical splits:
		" highlight VertSplit ctermbg=232 guibg=#080808		" same as SignColumn
		" highlight VertSplit ctermbg=238 guibg=#444444		" same as status line
		highlight VertSplit ctermfg=238 guifg=#444444 ctermbg=233 guibg=#121212		" fg: same as status line, bg: same as ColorColumn
		" set fillchars+=vert:\ 				" delete split | separators
		set fillchars+=vert:│					" complete utf fill separator
	endif
	if g:colors_name == "gruvbox"
		let g:airline_theme= "gruvbox"
	endif
	" highlight ColorColumn ctermbg=0 guibg=#000000 	" colorcolumn for wombat256
	" highlight ColorColumn ctermbg=232 guibg=#080808 	" colorcolumn for wombat256mod
	" highlight ColorColumn ctermbg=233 guibg=#121212	" colorcolumn for xoria256
	" highlight ColorColumn ctermbg=235 guibg=#262626	" colorcolumn for base16-default
	" highlight ColorColumn ctermbg=0 guibg=#303030		" colorcolumn for base16
endif

" colorscheme settings I want to be there even if I change themes:
highlight Comment cterm=italic gui=italic	" put comments in italic (needs to be after your colorscheme) (needs tmux to be correctly set)
highlight String cterm=italic gui=italic	" put strings in italic (needs to be after your colorscheme) (needs tmux to be correctly set)

" terminal: Use a blinking upright bar cursor in Insert mode, and a blinking block in normal
" this could be done with Plugin 'jszakmeister/vim-togglecursor'
" change cursor to a '|' when on vim console and insert mode:
if &term == 'xterm-256color' || &term == 'rxvt-unicode-256color' || &term == 'screen-256color' || &term == 'screen-256color-it'
	let &t_SI = "\<Esc>[5 q"
	let &t_EI = "\<Esc>[1 q"
	" urxvt has not implemented the bar cursor until 9.21, if that's the case, use an underbar: let &t_SI = "\<Esc>[3 q"
endif

set isfname+=32										"netrw: to open files with spaces
" }}}

" Persistence {{{
set viminfo+=% "save and restore the buffer list expected if vim is started with a file name argument
set viminfo+=n$HOME/.vim/.viminfo
" delete the empty buffer that appears on startup:
"autocmd VimEnter * nested if  bufname('')==''  &&  line('$') == 1 &&  col('$')==1 &&  !&modified | bd % | endif

set hidden							" don't mark buffers as abandoned if hidden
set history=1000
set undofile						" save undo's after file closes
set undodir=$HOME/.vim/undo			" where to save undo histories
set undolevels=1000					" how many undos
set undoreload=10000				" number of lines to save for undo
" }}}

" Backup and Swap files {{{
set backupdir=$HOME/.vim/backup		" for backup files
set directory=$HOME/.vim/backup		" for .swp files
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
nnoremap <leader><Tab>   :bnext<CR>
nnoremap <leader><S-Tab> :bprevious<CR>

" remap jk and kj to escape:  You'll never type it anyway, so it's great!
inoremap jk <Esc>
inoremap kj <Esc>

" use hjkl-movement between rows when soft wrapping:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" force yourself to stop using the arrow keys:
map <up>    <nop>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>

" move between tabs:
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" list of shared binds:
" write file without confirmation:
map <silent> <F2> :write<CR>

" remove trailing whitespaces:
"nnoremap <silent> <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let"@/=_s<Bar>:nohl<CR>

" remove trailing whitespaces:
map <F3> :%s/\s\+$//<CR>

" close buffer:
map <silent> <F4> <Esc>:bd<CR>

" toggle spell checking:
map <F5> :setlocal spell!<CR>

" open urls, files, etc. example: http://google.com:
noremap <F6> :!xdg-open <cfile><CR><CR>
set isfname+=32										" to open files with spaces

" open (vim-shell plugin):
"<F6>

" previous c error (c.vim plugin):
map  <silent> <F7>    <Esc>:cprevious<CR>

" next c error (c.vim plugin)
map  <silent> <F8>    <Esc>:cnext<CR>

" compile & link c code (alt+<F9> write + compile, ctrl+<F9> compile + run) (c.vim plugin)
"<F9>

" maximize (vim-shell plugin):
"<F11>

" Google it:
" <leader>?
function! s:goog()
  let url = 'https://encrypted.google.com/search?hl=en&q='
  " Excerpt from vim-unimpared
  let q = substitute(
        \ '"'.@0.'"',
        \ '[^A-Za-z0-9_.~-]',
        \ '\="%".printf("%02X", char2nr(submatch(0)))',
        \ 'g')
  call system('open ' . url . q)
endfunction
xnoremap <leader>? y:call <SID>goog()<cr>

" }}}

" Folding {{{
set foldmethod=syntax
set foldlevel=99
set foldnestmax=10			" max 10 depth
set nofoldenable			" don't fold files by default on open
set foldlevelstart=1		" start with fold level of 1
" }}}

" Launch {{{
set encoding=utf8
set autowrite								" automatically save before commands like :next and :make
set autochdir								" automatically cd into the directory that the file is in (this will break plugins if activated!!!)
"autocmd BufEnter * silent! lcd %:p:h		" automatically cd into the dir of the file. this breaks less
set autoread								" watch for file changes
set nomodeline								" dont make vim check beginning and ending lines of files for options. HUGE VULNERABILITY
" jump to the last position when reopening a file:
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
