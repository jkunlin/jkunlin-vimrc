" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/bundle')

" Make sure you use single quotes

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar' "need exuberant ctag installed
Plug 'bling/vim-airline'

Plug 'Lokaltog/vim-easymotion'
Plug 'mileszs/ack.vim' "need ack installed
Plug 'kien/ctrlp.vim'
Plug 'a.vim' "<leader>is confilct with c.vim, need to modify ~/.vim/bundle/a.vim/plugin/a.vim
Plug 'spf13/vim-autoclose'
"Plug 'Raimondi/delimitMate' "the same as vim-autoclose
Plug 'godlygeek/tabular' "align
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-fugitive'

"Plug 'godlygeek/csapprox' "for color
"Plug 'jellybeans.vim'
Plug 'morhetz/gruvbox'

Plug 'Konfekt/FastFold' "make fold fast
Plug 'gi1242/vim-tex-syntax' "make tex fast

Plug 'mbbill/undotree', { 'do': 'mkdir ~/.undodir'} "mkdir ~/.undodir
Plug 'vim-scripts/Conque-GDB'
Plug 'vim-scripts/matchit.zip'
Plug 'terryma/vim-multiple-cursors'
Plug 'lervag/vimtex' "required vim with +clientserver; alias vim='vim --servername vim'

" Initialize plugin system
call plug#end()

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

set completeopt=longest,menu
" Treat long lines as break lines
noremap j gj
noremap k gk
" Disable highlight when <leader><CR>
noremap <silent> <leader><CR> :noh<CR>
set cursorline
"hi CursorLine cterm=NONE ctermbg=darkgray guibg=darkgray
" hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
" switch between windows
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l
nnoremap <silent> + :vertical resize +5<CR>
nnoremap <silent> - :vertical resize -5<CR>

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
let g:UltiSnipsJumpBackwardTrigger="<c-j>" "<c-j> is <c-enter> actually
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
noremap <silent> <F10> <Esc>:cprevious<CR>
noremap <silent> <F12> <Esc>:cnext<CR>
let g:C_CplusCFlags = '-Wall -g -o0 -std=c++0x -c'
let g:C_CplusLFlags = '-Wall -g -o0 -std=c++0x'

" Ack
let g:ack_autoclose = 0

" NERD
noremap <silent> <F6> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"nmap <c-t> :browse tabnew<CR>M
"imap <c-t> <Esc>:browse tabnew<CR>M

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
let g:airline#extensions#whitespace = 0

" tagbar
noremap <silent> <F7> :TagbarToggle<CR>

" a.vim
nnoremap ;; :A<CR>

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

"vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_ignored_warnings = [
			\ 'Underfull',
			\ 'Overfull',
			\ 'specifier changed to',
			\ ]

inoremap <silent> jk <esc>

"" IMPORTANT: Uncomment one of the following lines to force
"" using 256 colors (or 88 colors) if your terminal supports it,
"" but does not automatically use 256 colors by default.
"set t_Co=256
""set t_Co=88
"let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

let g:gruvbox_italic=0
colorscheme gruvbox
set background=dark

"undotree
nnoremap <F8> :UndotreeToggle<cr>
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

"autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.cc :syn match comment "\v(^\s*//.*\n)+" fold

let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
