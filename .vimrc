" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/bundle')

" Make sure you use single quotes

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar' "need exuberant ctag installed
Plug 'bling/vim-airline'

Plug 'justinmk/vim-sneak'
" Plug 'Lokaltog/vim-easymotion'
Plug 'mileszs/ack.vim' "need ack (now is ag instead) installed
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/matchit.zip'

Plug 'mbbill/undotree', { 'do': 'mkdir ~/.undodir'}
Plug 'spf13/vim-autoclose'
"Plug 'Raimondi/delimitMate' "the same as vim-autoclose
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
" Plug 'tkhren/vim-textobj-numeral'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular' "align
Plug 'tpope/vim-fugitive'

"Plug 'godlygeek/csapprox' "for color
"Plug 'jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'Konfekt/FastFold' "make fold fast
Plug 'gi1242/vim-tex-syntax' "make tex fast
Plug 'lervag/vimtex' "required vim with +clientserver; alias vim='vim --servername vim', set okular with 'vim --remote-silent +%l \"%f\"'

Plug 'vim-scripts/Conque-GDB', { 'on': 'GDB' }


" Initialize plugin system
call plug#end()

set number
set relativenumber
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
set foldmethod=syntax
set foldlevel=100
set completeopt=longest,menu
set cursorline

inoremap <silent> jk <esc>
let mapleader = ";"

" Jump to the last edited line
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif

" autocmd filetype plaintex,tex :setlocal colorcolumn=80 formatoptions=tcq textwidth=80
autocmd filetype plaintex,tex :setlocal colorcolumn=80

" Treat long lines as break lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Disable highlight when <leader><CR>
noremap <silent> <leader><CR> :noh<CR>
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
nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ultisnip
let g:UltiSnipsSnippetDirectories=["~/.vim/bundle/vim-snippets", "UltiSnips", "mysnippets"]
function! g:UltiSnipsDocComment() abort
	execute "normal! idh" . "\<c-r>=UltiSnips#ExpandSnippet()\<CR>"
endfunction
autocmd BufNewFile *{.c,.cpp,.cc,.h} silent! call g:UltiSnipsDocComment()

" default <tab> <c-j> <c-k>
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<Enter>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<NL>" "<c-j> is <c-enter> actually
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

" quickfix
noremap <silent> <F10> <Esc>:cprevious<CR>
noremap <silent> <F12> <Esc>:cnext<CR>

" Ack
if executable('ag')
	" let g:ackprg = 'ag --nogroup --nocolor --column'
	let g:ackprg = 'ag --vimgrep'
endif
let g:ack_autoclose = 0

" ctrlp
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

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

" easy-motion
" map <Leader> <Plug>(easymotion-prefix)
" map <silent> <Leader>l <Plug>(easymotion-lineforward)
" map <silent> <Leader>j <Plug>(easymotion-j)
" map <silent> <Leader>k <Plug>(easymotion-k)
" map <silent> <Leader>h <Plug>(easymotion-linebackward)
" let g:EasyMotion_startofline = 0 " Keep cursor colum when JK motion

" vim-sneak
let g:sneak#s_next = 1

" airline
"set t_Co=256
set laststatus=2 "show status line even when only single window is opened
let g:airline#extensions#whitespace = 0

" tagbar
noremap <silent> <F7> :TagbarToggle<CR>

" a.vim
nnoremap <leader><leader> :A<CR>

" vim-autoclose
let g:autoclose_vim_commentmode = 1

" Conque-GDB
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly

" vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_ignored_warnings = [
			\ 'Underfull',
			\ 'Overfull',
			\ 'specifier changed to',
			\ ]

" csapprox
" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
" set t_Co=256
" set t_Co=88
" let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

" gruvbox
let g:gruvbox_italic=0
colorscheme gruvbox
set background=dark

" undotree
nnoremap <F8> :UndotreeToggle<cr>
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

" vim-surround
autocmd fileType plaintex,tex let b:surround_{char2nr('b')} = "\\textbf{\r}"
autocmd fileType plaintex,tex let b:surround_{char2nr('i')} = "\\textit{\r}"
autocmd fileType plaintex,tex let b:surround_{char2nr('$')} = "$\r$"
autocmd fileType plaintex,tex let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

" vim-textobj-user
let g:textobj_numeral_pattern = '\%(\<[[:digit:]]\+\%(\.[[:digit:]]\+\)\=\%([Ee][[:digit:]]\+\)\=\>\|\<0[xXbBoOdD][[:xdigit:]]\+\>\)'
let g:textobj_solution_pattern = g:textobj_numeral_pattern . '(' . g:textobj_numeral_pattern . ')'
call textobj#user#plugin('number', {
\   '-': {
\     'pattern': g:textobj_numeral_pattern,
\     'select': ['an', 'in'],
\   },
\   's': {
\     'pattern': g:textobj_solution_pattern,
\     'select': ['as', 'is'],
\   }
\ })

"autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.cc :syn match comment "\v(^\s*//.*\n)+" fold

command! GDB call plug#load('Conque-GDB') | ConqueGdb
