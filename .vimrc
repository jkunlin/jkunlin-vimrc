set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
""Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
""Plugin 'L9'
" Git plugin not hosted on GitHub
""Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
""Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
""Plugin 'rstacruz/sparkup', {
""'rtp': 'vim/'}
""" Avoid a name conflict with L9
""Plugin 'user/L9', {
""'name': 'newL9'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'bling/vim-airline'
Plugin 'mileszs/ack.vim' "need ack installed
Plugin 'kien/ctrlp.vim'
Plugin 'spf13/vim-autoclose'
"Plugin 'Raimondi/delimitMate' "the same as vim-autoclose
Plugin 'godlygeek/tabular' "align
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'godlygeek/csapprox' "for color
"Plugin 'jellybeans.vim'
Plugin 'morhetz/gruvbox'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-fugitive'
Plugin 'Konfekt/FastFold' "make fold fast
Plugin 'gi1242/vim-tex-syntax' "make tex fast
" Plugin 'itchyny/calendar.vim'
" Plugin 'mattn/calendar-vim'
Plugin 'mbbill/undotree' "mkdir ~/.undodir
Plugin 'majutsushi/tagbar' "need exuberant ctag installed
Plugin 'a.vim' "<leader>is confilct with c.vim, need to modify ~/.vim/bundle/a.vim/plugin/a.vim
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'vim-scripts/matchit.zip'
Plugin 'lervag/vimtex' "required vim with +clientserver; alias vim='vim --servername vim'
"Plugin 'LaTeX-Box-Team/LaTeX-Box'
"Plugin 'gerw/vim-latex-suite'
"" this is mostly a matter of taste. but LaTeX looks good with just a bit
"" of indentation.
"set sw=2
"" TIP: if you write your \label's as \label{fig:something}, then if you
"" type in \ref{fig: and press <C-n> you will automatically cycle through
"" all the figure labels. Very useful!
"set iskeyword+=:}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set nu
syntax enable
set termguicolors
set confirm
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set noswapfile
set ignorecase
set hlsearch
set incsearch
set smartindent
set backspace=indent,eol,start
set showcmd
if has("autocmd")  "Jump to the last edited line
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
"":inoremap ( ()<ESC>i
"":inoremap ) <c-r>=ClosePair(')')<CR>
"":inoremap {<CR> {<CR>}<ESC>O
"":inoremap } <c-r>=ClosePair('}')<CR>
"":inoremap [ []<ESC>i
"":inoremap ] <c-r>=ClosePair(']')<CR>
""function! ClosePair(char)
""    if getline('.')[col('.') - 1] == a:char
""        return "\<Right>"
""    else
""        return a:char
""    endif
""endfunction

set completeopt=longest,menu
" Treat long lines as break lines
map j gj
map k gk
" Disable highlight when <leader><CR>
map <silent> <leader><CR> :noh<CR>
set cursorline
"hi CursorLine cterm=NONE ctermbg=darkgray guibg=darkgray
" hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
" switch between windows
nmap <silent> <c-h> <c-w>h
nmap <silent> <c-j> <c-w>j
nmap <silent> <c-k> <c-w>k
nmap <silent> <c-l> <c-w>l
nmap <silent> + :vertical resize +5<CR>
nmap <silent> - :vertical resize -5<CR>

" vimgdb
let g:vimgdb_debug_file = ""
source ~/.vim/macros/gdb_mappings.vim
"map <F8> :bel 30vsplit gdb-variables<CR><c-w>h

" YCM
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
""let g:ycm_add_preview_to_completeopt = 1
""let g:ycm_autoclose_preview_window_after_completion = 1
""let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_seed_identifiers_with_syntax = 1
nnoremap <leader><leader> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ultisnip
" default <tab> <c-j> <c-k>
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<Enter>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>" "it is <c-enter> actually
""" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

function! g:UltiSnips_Complete()
	if pumvisible()
		return "\<c-n>"
	else
		call UltiSnips#ExpandSnippet()
		if g:ulti_expand_res == 0
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				return "\<tab>"
			endif
		endif
	endif
	return ""
endfunction
autocmd InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

function! g:UltiSnips_Expand()
	if pumvisible()
		call UltiSnips#ExpandSnippet()
		if g:ulti_expand_res == 0
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				if pumvisible()
					return "\<c-y>"
				endif
			endif
		endif
		return ""
	else
		return "\<c-g>u\<CR>"
	endif
endfunction
inoremap <silent> <CR> <C-R>=g:UltiSnips_Expand()<cr>

let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
"inoremap <expr> <CR> pumvisible() ? "<Esc>\<c-y>" : "\<C-g>u\<CR>"

" cvim, the first two mapping are also for Ack
map <silent> <F10> <Esc>:cprevious<CR>
map <silent> <F12> <Esc>:cnext<CR>
let g:C_CplusCFlags = '-Wall -g -o0 -std=c++0x -c'
let g:C_CplusLFlags = '-Wall -g -o0 -std=c++0x'

" Ack
let g:ack_autoclose = 0

" NERD
map <silent> <F6> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <c-t> :browse tabnew<CR>M
imap <c-t> <Esc>:browse tabnew<CR>M

" git-NERD
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "^",
    \ "Renamed"   : "->",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

"easy-motion
map <Leader> <Plug>(easymotion-prefix)
map <silent> <Leader>l <Plug>(easymotion-lineforward)
map <silent> <Leader>j <Plug>(easymotion-j)
map <silent> <Leader>k <Plug>(easymotion-k)
map <silent> <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " Keep cursor colum when JK motion

" airline
"set t_Co=256
set laststatus=2 "show status line even when only single window is opened
"let g:airline_detect_whitespace = 0
let g:airline#extensions#whitespace = 0

" tagbar
map <silent> <F7> :TagbarToggle<CR>

" a.vim
nmap ;; :A<CR>

" vim-autoclose
let g:autoclose_vim_commentmode = 1

" calendar
let g:calendar_google_calendar = 3
let g:calendar_google_task = 3

set foldmethod=syntax
set foldlevel=100

" Conque-GDB
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly

" latex suite
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
"set grepprg=grep\ -nH\ $*
"let g:tex_flavor='latex'

"vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_ignored_warnings = [
			\ 'Underfull',
			\ 'Overfull',
			\ 'specifier changed to',
			\ ]

"UltiSnips
"let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

inoremap <silent> jk <esc>

"" IMPORTANT: Uncomment one of the following lines to force
"" using 256 colors (or 88 colors) if your terminal supports it,
"" but does not automatically use 256 colors by default.
"set t_Co=256
""set t_Co=88
"let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

"undotree
nnoremap <F8> :UndotreeToggle<cr>
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif
