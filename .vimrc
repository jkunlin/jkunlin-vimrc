" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/bundle')

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.force
		!./install.py --clang-completer
	endif
endfunction
" Make sure you use single quotes
function! Cond(cond, ...)
	let opts = get(a:000, 0, {})
	return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
" Plug 'roxma/nvim-completion-manager', Cond(has('nvim') && (&ft !~ 'c\|cpp\|tex\|python'))
" Plug 'Shougo/deoplete.nvim', Cond(has('nvim') && (&ft !~ 'c\|cpp\|tex'), { 'do': ':UpdateRemotePlugins' })
" Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'tex', 'python', 'sh'], 'do': function('BuildYCM') }
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'w0rp/ale', { 'for': ['sh']} "apt-get install shellcheck
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar' "need exuberant ctag installed
Plug 'bling/vim-airline'
Plug 'rhysd/vim-grammarous'
Plug 'reedes/vim-lexical'
" Plug 'ConradIrwin/vim-bracketed-paste'
" Plug 'junegunn/rainbow_parentheses.vim'

" Plug 'justinmk/vim-sneak'
Plug 'Lokaltog/vim-easymotion'
Plug 'mileszs/ack.vim' "need ack (now is ag instead) installed
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-ctrlspace/vim-ctrlspace'

Plug 'mbbill/undotree', { 'do': 'mkdir ~/.undodir'}
" Plug 'spf13/vim-autoclose'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align',  { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/linediff.vim'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'airblade/vim-gitgutter'

"Plug 'godlygeek/csapprox' "for color
"Plug 'jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'Konfekt/FastFold' "make fold fast
Plug 'gi1242/vim-tex-syntax' "make tex fast
Plug 'lervag/vimtex' "required vim with +clientserver; alias vim='vim --servername vim', set okular with 'vim --remote-silent +%l \"%f\"'
" Plug 'vim-scripts/Conque-GDB', { 'on': 'GDB' }
" Plug 'critiqjo/lldb.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'huawenyu/neogdb.vim', { 'on': 'GDB'}
Plug 'sakhnik/nvim-gdb', { 'on': [] }
" Plug 'myusuf3/numbers.vim'
" Plug 'simeji/winresizer'

" Initialize plugin system
call plug#end()

set number
" set relativenumber
set lazyredraw
syntax enable
set termguicolors
set confirm
set autoindent
set cindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set noswapfile
set ignorecase
set hlsearch
set smartcase
set incsearch
set backspace=indent,eol,start
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set foldmethod=marker
set foldlevel=100
set completeopt=longest,menu
set scrolloff=1
set autoread
set cursorline
set hidden

inoremap <silent> jk <esc>
cnoremap <silent> jk <c-c>
if (has('nvim'))
	tnoremap <silent> jk <c-\><c-n>
endif
xnoremap <silent> v <c-c>
let mapleader = "\<space>"

" Jump to the last edited line
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif

augroup latex
	autocmd!
	autocmd filetype plaintex,tex setlocal colorcolumn=80
				\ tabstop=2
				\ shiftwidth=2
				\ softtabstop=2
augroup end

" Treat long lines as break lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Disable highlight when <leader><CR>
noremap <silent> <leader>hc :noh<CR>
" hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
" switch between windows
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l
nnoremap <silent> = :vertical resize +5<cr>
nnoremap <silent> - :vertical resize -5<cr>
nnoremap <silent> <leader>= :resize +5<cr>
nnoremap <silent> <leader>- :resize -5<cr>

nnoremap <leader>w :update<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap <leader>c :cclose<bar>lclose<cr>
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" cop to toggle setting
function! s:map_change_option(...)
	let [key, opt] = a:000[0:1]
	let op = get(a:, 3, 'set '.opt.'!')
	execute printf("nnoremap co%s :%s<bar>set %s?<cr>", key, op, opt)
endfunction

call s:map_change_option('r', 'relativenumber')

nnoremap zf zfa{ za

" Zoom
function! s:zoom()
	if winnr('$') > 1
		tab split
	elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
				\ 'index(v:val, '.bufnr('').') >= 0')) > 1
		tabclose
	endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" deoplete
let g:deoplete#enable_at_startup = 1

" nvim-completion-manager
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
""let g:ycm_add_preview_to_completeopt = 1
""let g:ycm_autoclose_preview_window_after_completion = 1
""let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_seed_identifiers_with_syntax = 1
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ultisnip
let g:UltiSnipsSnippetDirectories=["~/.vim/bundle/vim-snippets", "UltiSnips", "mysnippets"]
function! g:UltiSnipsDocComment() abort
	execute "normal! idh" . "\<c-r>=UltiSnips#ExpandSnippet()\<CR>"
endfunction
autocmd BufNewFile *{.c,.cpp,.cc,.h} silent! call g:UltiSnipsDocComment()

" default <tab> <c-j> <c-k>
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>" "<NL> or <c-j> is <c-enter> actually
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

function! g:UltiSnips_Complete()
	if pumvisible()
		return "\<c-n>"
	else
		call UltiSnips#ExpandSnippetOrJump()
		if g:ulti_expand_or_jump_res == 0
			return "\<tab>"
		endif
	endif
	return ""
endfunction
autocmd InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

function! g:UltiSnips_Expand()
	if pumvisible()
		call UltiSnips#ExpandSnippetOrJump()
		if g:ulti_expand_or_jump_res == 0
			return "\<c-y>\<cr>"
		endif
		return ""
	else
		return "\<cr>"
	endif
endfunction
inoremap <silent> <CR> <C-R>=g:UltiSnips_Expand()<cr>

" quickfix
noremap <silent> <F10> <Esc>:cprevious<CR>
noremap <silent> <F12> <Esc>:cnext<CR>

" Ack
if executable('ag')
	" let g:ackprg = 'ag --nogroup --nocolor --column'
	let g:ackprg = 'ag --vimgrep'
endif
let g:ack_autoclose = 0

" fzf
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" vim-ctrlspace
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
nnoremap <leader>s :CtrlSpace<cr>

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
map <Leader> <Plug>(easymotion-prefix)
map <silent> <Leader>ml <Plug>(easymotion-lineforward)
map <silent> <Leader>mj <Plug>(easymotion-j)
map <silent> <Leader>mk <Plug>(easymotion-k)
map <silent> <Leader>mh <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " Keep cursor colum when JK motion

" vim-sneak
let g:sneak#s_next = 1

" airline
"set t_Co=256
set laststatus=2 "show status line even when only single window is opened
" let g:airline#extensions#whitespace = 0
" let g:airline#extensions#tagbar#enabled = 0

" tcomment
" let g:tcomment#options_comments={'whitespace': 'left'}
" let g:tcomment#options_commentstring={'whitespace': 'left'}

" tagbar
noremap <silent> <F7> :TagbarToggle<CR>

" a.vim
nnoremap <leader>a :A<CR>
augroup unmap_space
	autocmd!
	autocmd vimEnter * iunmap <leader>ihn
	autocmd vimEnter * iunmap <leader>ih
	autocmd vimEnter * iunmap <leader>is
augroup END

" vim-autoclose
let g:autoclose_vim_commentmode = 1

" Conque-GDB
" let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
" let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
" let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly
" let g:ConqueGdb_Leader = "<leader>g"
" command! -complete=file -nargs=1 ConqueGdb call plug#load('Conque-GDB') | ConqueGdb <args>


" vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_latexlog = {
			\ 'overfull' : 0,
			\ 'underfull' : 0,
			\ 'font' : 0,
			\}
if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
			\ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
			\ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
			\ 're!\\hyperref\[[^]]*',
			\ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
			\ 're!\\(include(only)?|input){[^}]*',
			\ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
			\ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
			\ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
			\ 're!\\usepackage(\s*\[[^]]*\])?\s*\{[^}]*',
			\ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
			\ 're!\\[A-Za-z]*',
			\ ]
let g:vimtex_compiler_progname='nvr'

" csapprox
" IMPORTANT: Uncomment one of the following lines to force
" using 256 colors (or 88 colors) if your terminal supports it,
" but does not automatically use 256 colors by default.
" set t_Co=256
" set t_Co=88
" let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

" gruvbox
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" undotree
nnoremap <F8> :UndotreeToggle<cr>
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-surround
autocmd fileType plaintex,tex let b:surround_{char2nr('b')} = "\\textbf{\r}"
autocmd fileType plaintex,tex let b:surround_{char2nr('i')} = "\\textit{\r}"
autocmd fileType plaintex,tex let b:surround_{char2nr('$')} = "$\r$"
autocmd fileType plaintex,tex let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

" vim-easy-align
let g:easy_align_delimiters = {
\  't': { 'pattern': '\t',  'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 }
\}

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

" lldb
" nnoremap <leader><cr> :LL<space>
" nmap <M-b> <Plug>LLBreakSwitch
" nmap <M-n> :LL next<cr>
" nmap <M-c> :LL continue<cr>
" nnoremap <F5> :LLmode debug<cr>
" nnoremap <leader><F5> :LLmode code<cr>

" neogdb
" nmap <M-b> :GdbToggleBreak<cr>
" nmap <M-n> :GdbNext<cr>
" nmap <M-c> :GdbContinue<cr>
" command! -complete=file -nargs=1 Neogdb call plug#load('neogdb.vim') | GdbLocal confloc#me <args>

" nvim-gdb
command! -complete=file -nargs=1 Gdb call plug#load('nvim-gdb') | GdbStart gdb -q -f <args>

" vim-grammarous
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
	nmap <buffer>gn <Plug>(grammarous-move-to-next-error)
	nmap <buffer>gp <Plug>(grammarous-move-to-previous-error)
	nmap <buffer>gf <Plug>(grammarous-fixit)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
	nunmap <buffer>gn
	nunmap <buffer>gp
	nunmap <buffer>gf
endfunction

" vim-lexical
augroup lexical
	autocmd!
	autocmd FileType text call lexical#init()
	autocmd FileType plaintex,tex call lexical#init()
augroup END
let g:lexical#spell_key = '<leader>s'

" vim-diff-enhanced
if &diff
	let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
nnoremap <silent> <leader>g :!neato -Teps -o %:r.eps %<cr><cr>

" auto-pairs
augroup auto-pairs
	autocmd!
	autocmd FileType plaintex,tex let g:AutoPairs['$']='$'
augroup END

" python
autocmd FileType python nnoremap <Leader>i :!isort %<CR><CR>
autocmd FileType python vnoremap = :!yapf<CR>
