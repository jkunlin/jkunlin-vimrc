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
Plugin 'bling/vim-airline'
Plugin 'mileszs/ack.vim' "need ack installed
Plugin 'kien/ctrlp.vim'
Plugin 'spf13/vim-autoclose'
Plugin 'godlygeek/tabular'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/calendar.vim'
" Plugin 'mattn/calendar-vim'
Plugin 'majutsushi/tagbar' "need exuberant ctag installed
Plugin 'a.vim' "<leader>is confilct with c.vim, need to modify ~/.vim/bundle/a.vim/plugin/a.vim
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

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
if has('gui_running')
    set background=light
else
    set background=dark
endif
"colorscheme solarized
syntax enable
if has('gui_running')
	set guifont=Courier_New:h10:cANSI
endif
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
" hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
" switch between windows
nmap <silent> <c-h> <c-w>h
nmap <silent> <c-j> <c-w>j
nmap <silent> <c-k> <c-w>k
nmap <silent> <c-l> <c-w>l

" vimgdb
let g:vimgdb_debug_file = ""
source ~/.vim/macros/gdb_mappings.vim
"map <F8> :bel 30vsplit gdb-variables<CR><c-w>h

" YCM
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ultisnip
" default <tab> <c-j> <c-k>
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Enter>"
let g:UltiSnipsJumpForwardTrigger="<Enter>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>" "it is <c-enter> actually
""" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

function! g:UltiSnips_Complete()
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res == 0
		call UltiSnips#JumpForwards()
		if g:ulti_jump_forwards_res == 0
			return "\<enter>"
		endif
	endif
	return ""
endfunction
autocmd BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" cvim, the first twoo also for Ack
map <silent> <F10> <Esc>:cprevious<CR>
map <silent> <F12> <Esc>:cnext<CR>
let g:C_CplusCFlags = '-Wall -g -o0 -std=c++0x -c'
let g:C_CplusLFlags = '-Wall -g -o0 -std=c++0x'

" NERD
map <silent> <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <c-t> :browse tabnew<CR>M 
imap <c-t> <Esc>:browse tabnew<CR>M

"easy-motion
map <Leader> <Plug>(easymotion-prefix)
map <silent> <Leader>l <Plug>(easymotion-lineforward)
map <silent> <Leader>j <Plug>(easymotion-j)
map <silent> <Leader>k <Plug>(easymotion-k)
map <silent> <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " Keep cursor colum when JK motion

" airline
set t_Co=256
set laststatus=2 "show status line even when only single window is opened
let g:airline_detect_whitespace = 0

" tagbar
map <silent> <F3> :TagbarToggle<CR>

" calendar
let g:calendar_google_calendar = 3
let g:calendar_google_task = 3
