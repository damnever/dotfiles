" VIM configs for damnever.
" Inspired by wklken/k-vim


let mapleader = ','
let g:mapleader = ','
set nocompatible


call plug#begin('~/.vim/plugins')

" ==> themes
" solarized
Plug 'altercation/vim-colors-solarized'
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
let g:solarized_termcolors=256
" molokai
Plug 'tomasr/molokai'
let g:molokai_original = 1
let g:rehash256 = 1
Plug 'flazz/vim-colorschemes'


" ==> airline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
" https://github.com/bling/vim-airline/wiki/Screenshots
" tomorrow, bubblegum ..
let g:airline_theme='laederon'


" ==> Better Rainbow Parentheses
Plug 'kien/rainbow_parentheses.vim'

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" ==> file tree
Plug 'scrooloose/nerdtree'

nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
" close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let NERDTreeShowHidden = 1


" ==> tagbar
Plug 'majutsushi/tagbar'

nmap <leader>b :TagbarToggle<CR>
let g:tagbar_autofocus = 1
" let g:tagbar_autoshowtag = 1
" let g:tagbar_show_visibility = 1
" tagbar for go
" 1. install gotags 'go get -u github.com/jstemmer/gotags'
" for gotags. work with tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


" ==> quick run, [, + r]
Plug 'thinca/vim-quickrun'

let g:quickrun_config = {
\   "_" : {
\       "outputter" : "message",
\   },
\}
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)


" ==> provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'Raimondi/delimitMate'

au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]


" ==> intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

let g:NERDSpaceDelims=1


" ==> remove trailing whitespace [, + <Space>]
Plug 'bronson/vim-trailing-whitespace'
map <leader><space> :FixWhitespace<cr>


" ==> quick movement [,, + w/fx/h/j/k/l]
Plug 'Lokaltog/vim-easymotion'

let g:EasyMotion_smartcase = 1
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)


" ==> quickscope movement [f/F/t/T]
Plug 'unblevable/quick-scope'

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


" ==> Full path fuzzy file, buffer, mru, tag, ... finder for Vim, and a function navigator for ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'

let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']


" ==> An ack/ag/pt/rg powered code search and view tool, [\]
Plug 'dyng/ctrlsf.vim'

nmap \ <Plug>CtrlSFCwordPath<CR>
" let g:ctrlsf_position = 'below'
let g:ctrlsf_winsize = '40%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
" Note: cannot use <CR> or <C-m> for open
" Use : <sapce> or <tab>
let g:ctrlsf_mapping = {
    \ "open"  : "<Space>",
    \ "openb" : "O",
    \ "tab"   : "t",
    \ "tabb"  : "T",
    \ "prevw" : "p",
    \ "quit"  : "q",
    \ "next"  : "<C-J>",
    \ "prev"  : "<C-K>",
    \ "pquit" : "q",
    \ }


" ==> for repeat -> enhance surround.vim, . to repeat command
Plug 'tpope/vim-repeat' | Plug 'tpope/vim-surround'

" ==> git
Plug 'tpope/vim-fugitive'

" ==> shows a git diff in the gutter
Plug 'airblade/vim-gitgutter'

let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_max_signs = 666


" ==> insert LICENSE
Plug 'antoyo/vim-licenses'

let g:licenses_copyright_holders_name = 'XiaoChao Dong (@damnever) <dxc.wolf@gmail.com>'
let g:licenses_default_commands = ['Bsd3', 'mit']


" ==> A code-completion engine for Vim
function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status != 'installed' || a:info.force
        !./install.py --clang-completer " --system-libclang --system-boost
    endif
endfunction
let g:plug_url_format = 'git@github.com:%s.git'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
unlet g:plug_url_format

let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion=['<c-p>']
" let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_goto_buffer_command = 'horizontal-split'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
" old version
if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif
" let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_filetype_blacklist = {
    \ 'tagbar' : 1,
    \ 'gitcommit' : 1,
    \}
let g:ycm_server_to_python_interpreter = "/usr/bin/python"


" ==> syntax plugins
Plug 'scrooloose/syntastic'

let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic_error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>
highlight SyntasticErrorSign guifg=white guibg=black
let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['java'] }
" python
let g:syntastic_python_checkers=['pyflakes', 'pep8'] " 使用pyflakes,速度
" error code: http://pep8.readthedocs.org/en/latest/intro.html#error-codes
" W601: use 'in' replace 'has_key', but I got a method named 'has_key' sometimes...
" E731: do not assign a lambda expression, use a def? fuck it...
let g:syntastic_python_pep8_args='--ignore=E124,E225,E226,E227,E302,E501,E712,W601,E731'
" golang
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" ==> Python, pip install pep8 pyflakes pylint
Plug 'hdima/python-syntax', { 'for': 'python' }
let python_highlight_all = 1

Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }


" ==> Golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_fail_silently = 0
let g:go_play_open_browser = 0
let g:go_fmt_command = "goimports"


" ==> tmux [Ctrl + h,i,j,k]
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}


" ==> close open HTML/XML tags
Plug 'docunext/closetag.vim', { 'for': ['html', 'xml'] }

let g:closetag_html_style=1


" => markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

let g:vim_markdown_folding_disabled = 1


" misc
Plug 'solarnz/thrift.vim', { 'for': 'thrift' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
Plug 'fatih/vim-nginx' , {'for': 'nginx'}

call plug#end()



syntax on " enable vim syntax colors
filetype plugin indent on " FIXME: dumplicated with the follows?
filetype on " enable filetype detection
filetype indent on " enable loading the indent file for specific file types
filetype plugin on " enable loading the plugin files for specific file types

set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set shiftround

set history=1000
set autoread
set nobackup
set noswapfile
set wildignore=*.o,*.swp,*.bak,*.pyc,*.pyo,*.class,.svn,.git,__pycache__
set cursorcolumn " highlight the current column
set cursorline " highlight current line
set t_ti= t_te= " show screen shot after quit
set mouse-=a " disable use of the mouse for all modes
set visualbell
set t_vb=
set selection=inclusive
set selectmode=mouse,key
set title
set viminfo^=% " save the buffer
set magic " regex
set backspace=eol,start,indent " allow backspacing over autoindent, line breaks and start of insert action
set whichwrap+=<,>,h,l

set hidden " http://vim.wikia.com/wiki/Example_vimrc
set ruler " display the cursor position on the last line of the screen or in the status line of a window
set wildmenu " better command-line completion
set showcmd " show partial commands in the last line of the screen
" set cmdheight=3 " to avoid many cases of having to "press <Enter> to continue"
set showmode
set scrolloff=7 " min top/down padding which cursor cannot reach
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2 " always display the status line
set number " display line numbers
set nowrap
set showmatch
set matchtime=2

set hlsearch
set incsearch
set ignorecase
set smartcase

set foldenable
set foldmethod=indent
set foldlevel=50
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfunc

set wildmode=list:longest
set ttyfast

set nrformats=

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
"set enc=2byte-gb18030
set termencoding=utf-8
set ffs=unix,dos,mac

set formatoptions+=m
set formatoptions+=B

autocmd! bufwritepost _vimrc source %
autocmd! bufwritepost .vimrc source %

set completeopt=longest,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

function! HideNumber()
    set number!
endfunc
nnoremap <leader>hn :call HideNumber()<CR>

au InsertLeave * set nopaste
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

noremap H ^
noremap L $

map Y y$
" copy to clipboard
vnoremap <leader>y "+y"

cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

map <space> /
nnoremap / /\v
vnoremap / /\v
noremap <silent><leader>/ :nohls<CR>

nnoremap <C-t>     :tabnew<CR>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

" reselect after indent
vnoremap < <gv
vnoremap > >gv

" force write with sudo
cmap w!! w !sudo tee >/dev/null %

inoremap <C-c> <ESC>

nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

" for python comment indent when enter new line
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType css set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd
autocmd BufRead,BufNewFile *.vue,*.part set filetype=html

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,go,javascript,python,rust,lua,scheme,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    if &filetype == 'python'
        call setline(1, "\# -*- coding: utf-8 -*-")
        call append(1, "")
        " call append(2, "from __future__ import print_function, division, absolute_import")
    endif

    normal G
    normal o
endfunc

if has("autocmd")
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|WARN\|WARNING\|ERROR\|IDEA\|NOTICE\)')
  endif
endif

set background=dark " light
set t_Co=256
" hi Normal ctermfg=256 ctermbg=none
" solarized, desert ..
colorscheme molokai

hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline