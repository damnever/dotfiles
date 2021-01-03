" VIM configs for damnever.
set encoding=utf-8
scriptencoding utf-8


let mapleader = ','
let g:mapleader = ','
set nocompatible


call plug#begin('~/.vim/plugins')

let s:python_binary = substitute(resolve(system('pyenv which python')), '\n\+$', '', '')
" https://github.com/neovim/neovim/blob/11bf89e3b58be1dd534b4ea49b1988150cf7d4b8/runtime/doc/provider.txt#L59
if system(s:python_binary . ' -V') =~ '2\.'
    let g:python_host_prog = s:python_binary
    set pyxversion=2
else
    let g:python3_host_prog = s:python_binary
    set pyxversion=3
endif

" https://stackoverflow.com/a/24931292/2996656
let g:omni_sql_no_default_maps = 1

" ==> file tree
Plug 'preservim/nerdtree'

nmap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeIgnore = [
      \ '__pycache__', '\.pyc$', '\.pyo$',
      \ '\.obj$', '\.o$', '\.so$', '\.egg$', '\.beam$',
      \ '^\.git$', '^\.svn$', '^\.hg$'
      \ ]
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeShowHidden = 1
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


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
      \   'p:package',
      \   'i:imports:1',
      \   'c:constants',
      \   'v:variables',
      \   't:types',
      \   'n:interfaces',
      \   'w:fields',
      \   'e:embedded',
      \   'm:methods',
      \   'r:constructor',
      \   'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \   't' : 'ctype',
      \   'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
      \   'ctype' : 't',
      \   'ntype' : 'n'
      \ },
      \   'ctagsbin'  : 'gotags',
      \   'ctagsargs' : '-sort -silent'
      \ }


" ==> quick run, [, + r]
Plug 'thinca/vim-quickrun'

let g:quickrun_config = {
      \   '_' : {
      \       'outputter' : 'message',
      \   },
      \}
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)


" ==> provides insert mode auto-completion for quotes, parens, brackets, etc.
" Plug 'Raimondi/delimitMate'
" au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
" au FileType rust let b:delimitMate_quotes = '"'
" Plug 'jiangmiao/auto-pairs'
" let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}


" ==> intensely orgasmic commenting
Plug 'preservim/nerdcommenter'

let g:NERDSpaceDelims = 1


" ==> remove trailing whitespace [, + <Space>]
" Plug 'ntpeters/vim-better-whitespace'
" map <leader><space> :StripWhitespace<cr>
" autocmd BufEnter * EnableStripWhitespaceOnSave
" let g:better_whitespace_filetypes_blacklist = [
"       \ 'go',
"       \ 'diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown'
"       \ ]
" let g:better_whitespace_enabled = 1


" ==> quick movement :help easymotion.txt
Plug 'easymotion/vim-easymotion'

let g:EasyMotion_smartcase = 1
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)
" ==> quickscope movement [f/F]
" Plug 'unblevable/quick-scope'

" let g:qs_highlight_on_keys = ['f', 'F']


" ==> multiple selections
" https://github.com/terryma/vim-multiple-cursors/issues/27
Plug 'terryma/vim-multiple-cursors'


" ==> for repeat -> enhance surround.vim, . to repeat command
Plug 'tpope/vim-repeat' | Plug 'tpope/vim-surround'


" ==> git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'


" ==> insert LICENSE
Plug 'antoyo/vim-licenses'

let g:licenses_copyright_holders_name = 'XiaoChao Dong (@damnever) <dxc.wolf@gmail.com>'
let g:licenses_default_commands = ['Bsd3', 'mit']


" ==> code snippets, edit snippets [, + es]
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories  = ['codesnippets']
let g:UltiSnipsSnippetsDir = '~/.vim/codesnippets'
let g:UltiSnipsEditSplit = 'context'
nnoremap <Leader>es :UltiSnipsEdit<Cr>


" ==> Full language server protocol support, and more than that!!!
" Configuration file is located at ./config/nvim/coc-settings.json
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" https://github.com/neoclide/coc.nvim#extensions
" \ 'coc-java',
" \ 'coc-tabnine',
let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-lists',
    \ 'coc-dictionary',
    \ 'coc-word',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-snippets',
    \ 'coc-rls',
    \ 'coc-git',
    \]

hi default link CocErrorSign Error
hi default link CocWarningSign Error
hi default link CocInfoSign Exception
hi default link CocHintSign Exception
" Use <c-n> for trigger completion.
" inoremap <silent><expr> <c-n> coc#refresh()
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> <leader>jt <Plug>(coc-type-definition)
nmap <silent> <leader>ji <Plug>(coc-implementation)
nmap <silent> <leader>jr <Plug>(coc-references)
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-[> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-[>"
  nnoremap <silent><nowait><expr> <C-]> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-]>"
endif
" Use K for show documentation in preview window
nnoremap <silent> <s-k> :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

function! CocSplitIfNotOpen(...)
    " Ref: https://github.com/neoclide/coc.nvim/blob/7e9e0e91e24fc447e96079ae59e9f6caffe604a4/autoload/coc/util.vim#L380-L383
    let cursorCmd = ''
    let fname = a:1
    if a:0 == 2  " Two arguments.
        let cursorCmd = a:1
        let fname = a:2
    endif
    if fname != fnamemodify(expand('%'), ':p:~:.')
        exec 'split '.fname
    endif
    if len(cursorCmd)
        exec cursorCmd
    endif
endfunction
command! -nargs=+ CocJumpCmd :call CocSplitIfNotOpen(<f-args>)

" coc-pairs
augroup CocPairsFileTypes
    autocmd FileType rust let b:coc_pairs_disabled = ["'"]
    autocmd FileType vim let b:coc_pairs_disabled = ['"']
augroup END

" coc-lists
nnoremap <silent> <leader>p :exe 'CocList files'<CR>

command! -nargs=+ -complete=custom,s:GrepArgs GA exe 'CocList -A grep '.<q-args>
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
      \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, '\n')
endfunction

vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList -A grep '.word
endfunction

nnoremap <silent> \  :exe 'CocList -I -A --normal --input='.expand('<cword>').' words'<CR>

" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

" unbelievable!!!
augroup CocActionEditorOrganizeImports
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END


" ==> Asynchronous Lint Engine (vim8 required).
Plug 'w0rp/ale'

hi default link ALEErrorSign Error
hi default link ALEWarningSign Exception
let g:ale_disable_lsp = 1
let g:ale_sign_priority = 30
let g:ale_completion_enabled = 0
let g:ale_history_log_output = 0  " Save memory.
let g:ale_history_enabled = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '∙'
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] [%linter%] %(code): %%s'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
let g:ale_list_window_size = 5
let g:ale_fix_on_save = 1
" \'go': ['goimports'],
let g:ale_fixers = {
    \'*': ['remove_trailing_lines', 'trim_whitespace'],
    \'rust': ['rustfmt'],
    \'c': ['clang-format'],
    \'javascript': ['prettier'],
    \}
let g:ale_pattern_options = {
    \   '\.h$': {
    \       'ale_fixers': ['clang-format'],
    \   },
    \}
let g:ale_lint_delay = 111
let g:ale_linters = {'vim': ['vint'], 'sh': ['shellcheck'],}
    " \'c': ['clangtidy'],
    " \'python': ['flake8'],
    " \'go': ['gometalinter'],
    " \'rust': ['cargo'],
    " \'elixir': ['credo'],
    " \}
let g:ale_linters_explicit = 1
let g:ale_rust_cargo_use_clippy = 1
let g:ale_vim_vint_show_style_issues = 0
let g:ale_sh_shellcheck_options = '-x'
let g:ale_c_clangformat_options='-style="{BasedOnStyle: Google, IndentWidth: 4}"'
let g:ale_python_yapf_executable = fnamemodify(s:python_binary, ':h').'/yapf'
let g:ale_javascript_prettier_options = '--print-width 94 --arrow-parens always'
" let g:ale_python_flake8_executable = fnamemodify(s:python_binary, ':h').'/flake8'
" let g:ale_python_flake8_use_global = 1
" let g:ale_go_gometalinter_options = '--fast -j4 --deadline=5s --vendor --disable-all --enable-gc
      " \ --enable=vet
      " \ --enable=errcheck
      " \ --enable=golint
      " \ --enable=lll --line-length=120
      " \ --enable=unused
      " \ --enable=unparam'


" ==> Syntax related plugins

" Python
Plug 'hdima/python-syntax', { 'for': 'python'  }
let python_highlight_all = 1
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Erlang
" Plug 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
" Plug 'vim-erlang/vim-erlang-compiler', { 'for': 'erlang' }
" Plug 'vim-erlang/vim-erlang-omnicomplete', { 'for': 'erlang' }
" Elixir
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

" HTML/CSS/Javascript
Plug 'docunext/closetag.vim', { 'for': ['html', 'xml'] }
let g:closetag_html_style = 1
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

Plug 'posva/vim-vue', {'for': 'vue'}
autocmd FileType vue syntax sync fromstart

" markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1

" tmux [Ctrl + h,i,j,k]
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}

" others
Plug 'cespare/vim-toml'
Plug 'solarnz/thrift.vim', { 'for': 'thrift' }
Plug 'kevinoid/vim-jsonc', { 'for': 'json' }
Plug 'ekalinin/Dockerfile.vim', {'for': 'Dockerfile'}
Plug 'fatih/vim-nginx' , {'for': 'nginx'}


" ==> themes
" solarized
Plug 'altercation/vim-colors-solarized'
let g:solarized_termtrans = 1
let g:solarized_contrast = 'normal'
let g:solarized_visibility = 'normal'
let g:solarized_termcolors = 256
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
" laederon, tomorrow, bubblegum, wombat ..
let g:airline_theme = 'dark'


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
let g:rbpt_max = 64
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Plug 'Yggdroot/indentLine'
" let g:indentLine_setColors = 0
" let g:indentLine_char = '¦'  " | ¦ ┆ ┊
" let g:indentLine_concealcursor = 'inc'
" let g:indentLine_conceallevel = 1
call plug#end()

" FIXME: separate into multiple files???
if filereadable(expand('go.mod'))  " not working..
    let s:goimportslocal = ''
    for s:line in readfile('go.mod')
        if stridx(s:line, 'module ') == 0
            let s:goimportslocal = split(s:line, 'module ')[0]
            break
        endif
    endfor
    call coc#config('languageserver.golang.initializationOptions', {
        \ 'local': s:goimportslocal,
        \ })
endif


if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

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

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
set signcolumn=yes
set completeopt-=preview

set list
set listchars=tab:\ \ ,trail:∙,extends:❯,precedes:❮,nbsp:•
set fillchars+=vert:│

set history=1000
set autoread
set nobackup
set noswapfile
set wildignore=*.o,*.swp,*.bak,*.pyc,*.pyo,*.class,*.beam,.svn,.git,__pycache__

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
set cmdheight=3 " to avoid many cases of having to "press <Enter> to continue"
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
    exe 'normal! zM'
    let g:FoldMethod = 1
  else
    exe 'normal! zR'
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

" set nocursorline
" set nocursorcolumn
" set synmaxcol=160
syntax sync minlines=888
set re=1

autocmd! bufwritepost _vimrc source %
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc source %

autocmd InsertLeave * if pumvisible() == 0|pclose|endif


if has('autocmd')
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
  return ''
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

" Better man page for C
function! CDoc(num)
  execute '! man ' . a:num . ' ' . expand('<cword>')
  if v:shell_error == 0 || a:num == ''
    return
  endif
  if a:num == '2'
    call CDoc('3')
  else
    call CDoc('')
  endif
endfunction
autocmd FileType c,cpp nnoremap <S-K> :call CDoc('2')<CR>

" for python comment indent when enter new line
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType vim set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType css set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType typescript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType yaml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType json set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType toml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
" autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd BufRead,BufNewFile *.wxml set filetype=html
autocmd BufRead,BufNewFile *.wxss set filetype=css
autocmd FileType txt,markdown,rst,asciidoc :call WrapingText()
function! WrapingText()
  setlocal wrap
  setlocal linebreak
  " setlocal nolist
endfunction

autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
  if &filetype == 'sh'
    call setline(1, '#!/bin/bash')
  endif
endfunc

autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|WARNING\|WARN\|ERROR\|IDEA\|NOTICE\|MARK\|N\.B\.\)')
autocmd Syntax * call matchadd('Debug', '\W\zs\(todo\|fixme\|bug\|hack\|note\|notice\|mark\|n\.b\.\)')

" Ref: https://github.com/neovim/neovim/issues/7994
autocmd InsertLeave * set nopaste

set termguicolors
set background=dark " light
set t_Co=256
" hi Normal ctermfg=256 ctermbg=none
" molokai, solarized, desert, gruvbox, onedark ..
colorscheme molokai

if has('nvim')
    " FUck? https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-shape-in-the-terminal
    set guicursor=
endif
set cursorcolumn " highlight the current column
set cursorline " highlight current line
hi CursorLine term=underline cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE guibg=NONE
hi CursorColumn term=NONE cterm=NONE ctermfg=NONE ctermbg=239 gui=NONE guifg=NONE guibg=#4e4e4e

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

" For 'terryma/vim-multiple-cursors'
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual

set exrc
set secure
