local vim = vim
local lib = require('lib')

local function set_global_variables()
    vim.g.mapleader = [[,]]
    vim.g.maplocalleader = [[,]]

    local python_bin = vim.fn.substitute(vim.fn.resolve(vim.fn.system('pyenv which python')), '\\n\\+$', '', '')
    if string.match(vim.fn.system(python_bin .. ' -V'), '^2%..+') == nil then
        vim.g.python3_host_prog = python_bin
    else
        vim.g.python_host_prog = python_bin
    end

    -- Disable builtin plugins.
    local builtin_plugins = {
        'gzip', 'man', 'matchit', 'matchparen', 'netrwPlugin',
        'shada', 'tarPlugin', 'tohtml',
        'tutor', 'zipPlugin',
    }
    for _, plugin in ipairs(builtin_plugins) do
        vim.g['loaded_' .. plugin] = 1
    end
end

local function set_common_keymaps()
    vim.keymap.set('', '<Left>', '<Nop>', { remap = true })
    vim.keymap.set('', '<Right>', '<Nop>', { remap = true })
    vim.keymap.set('', '<Up>', '<Nop>', { remap = true })
    vim.keymap.set('', '<Down>', '<Nop>', { remap = true })

    vim.keymap.set('', '<C-j>', '<C-W>j', { remap = true })
    vim.keymap.set('', '<C-k>', '<C-W>k', { remap = true })
    vim.keymap.set('', '<C-h>', '<C-W>h', { remap = true })
    vim.keymap.set('', '<C-l>', '<C-W>l', { remap = true })

    vim.keymap.set('', 'H', '^')
    vim.keymap.set('', 'L', '$')

    vim.keymap.set('', 'Y', 'y$', { remap = true })
    vim.keymap.set('v', '<leader>y', '"+y"')

    vim.keymap.set({ 'n', 'v' }, '/', '/\\v')
    vim.keymap.set('', '<leader>/', ':nohls<CR>', { silent = true })

    -- tab related
    vim.keymap.set('n', '<C-t>', ':tabnew<CR>')
    vim.keymap.set('n', '<leader>1', '1gt')
    vim.keymap.set('n', '<leader>2', '2gt')
    vim.keymap.set('n', '<leader>3', '3gt')
    vim.keymap.set('n', '<leader>4', '4gt')
    vim.keymap.set('n', '<leader>5', '5gt')
    vim.keymap.set('n', '<leader>6', '6gt')
    vim.keymap.set('n', '<leader>7', '7gt')
    vim.keymap.set('n', '<leader>8', '8gt')
    vim.keymap.set('n', '<leader>9', '9gt')
    vim.keymap.set('n', '<leader>0', ':tablast<CR>')
    vim.keymap.set('n', '<leader>tt', [[:execute 'tabnext ' . g:last_active_tab<cr>]])
    vim.cmd([[autocmd TabLeave * let g:last_active_tab = tabpagenr()]])

    vim.keymap.set('i', '<C-c>', '<ESC>')
    vim.keymap.set('n', '<leader>q', ':q<CR>')
    vim.keymap.set('n', '<leader>w', ':w<CR>')
end

--- :set options
local function set_options()
    -- opt('smartindent', true)
    vim.o.autoindent = true
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.softtabstop = 4
    vim.o.smarttab = true
    vim.o.expandtab = true
    vim.o.shiftround = true

    vim.o.updatetime = 300 -- Smaller updatetime for CursorHold & CursorHoldI
    vim.o.shortmess = vim.o.shortmess .. 'c'
    vim.o.signcolumn = 'yes'
    -- opt('completeopt', 'preview', '-')
    vim.o.list = true
    vim.o.listchars = 'tab:  ,trail:∙,extends:❯,precedes:❮,nbsp:•'
    vim.o.fillchars = vim.o.fillchars .. 'vert:│'

    vim.o.undofile = true
    vim.o.undodir = lib.ensure_data_cache_dir('undo')
    vim.o.history = 2000
    vim.o.autoread = true
    vim.o.backup = false
    vim.o.swapfile = false
    vim.o.wildignore = '*.o,*.swp,*.bak,*.pyc,*.pyo,*.class,*.beam,.svn,.git,__pycache__'

    vim.o.mouse = nil
    vim.o.visualbell = true
    -- opt('selection', 'inclusive')
    -- opt('selectmode', 'mouse,key')
    vim.o.title = true
    -- vim.o.viminfo:prepend('%') -- save the buffer
    vim.o.magic = true
    vim.o.backspace = 'eol,start,indent'
    vim.o.whichwrap = 'b,s,<,>,h,l'

    vim.o.hidden = true
    vim.o.ruler = true
    vim.o.wildmenu = true
    vim.o.showcmd = true
    vim.o.cmdheight = 3
    vim.o.showmode = false
    vim.o.scrolloff = 7
    -- opt('statusline', '%<%f\\ %h%m%r%=%k[%{(&fenc==\\"\\")?&enc:&fenc}%{(&bomb?\\",BOM\\":\\"\\")}]\ %-14.(%l,%c%V%)\\ %P')
    vim.o.laststatus = 2
    vim.o.number = true
    -- opt('nowrap', true)
    vim.o.showmatch = true
    vim.o.matchtime = 2

    vim.o.hlsearch = true
    vim.o.incsearch = true
    vim.o.ignorecase = true
    vim.o.smartcase = true
    vim.o.foldenable = true
    -- opt('foldmethod', 'indent')
    -- opt('foldlevel', 50)

    vim.o.wildmode = 'list:longest'
    vim.o.encoding = 'utf-8'
    vim.o.termencoding = 'utf-8'

    vim.o.formatoptions = '1jcroql'

    vim.o.exrc = true
    vim.o.secure = true

    vim.o.termguicolors = true
end

local function set_colorscheme(name, background)
    name = name ~= nil and name or 'molokai'
    background = background ~= nil and background or 'dark'
    vim.o.background = background
    -- opt('t_Co', '256')
    vim.cmd('colorscheme ' .. name)
end

-- TODO: call packer sync manually.
local function set_cursor_line()
    -- https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-shape-in-the-terminal
    vim.o.guicursor = nil
    vim.o.cursorcolumn = true
    vim.o.cursorline = true
    -- vim.cmd([[
    -- hi CursorLine term=underline cterm=underline ctermfg=NONE ctermbg=NONE gui=underline guifg=NONE guibg=NONE
    -- hi CursorColumn term=NONE cterm=NONE ctermfg=NONE ctermbg=239 gui=NONE guifg=NONE guibg=#4e4e4e
    -- ]])
end

local function set_misc_autocmds()
    vim.cmd([[
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * set nopaste

        autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#
        autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
        autocmd FileType vim set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
        autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
        autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
        autocmd FileType css set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
        " autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
        " autocmd FileType typescript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
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

        " Ref: https://github.com/neovim/neovim/issues/7994
        autocmd InsertLeave * set nopaste

        " hi! link SignColumn   LineNr
        " hi! link ShowMarksHLl DiffAdd
        " hi! link ShowMarksHLu DiffChange

        " highlight clear SpellBad
        " highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
        " highlight clear SpellCap
        " highlight SpellCap term=underline cterm=underline
        " highlight clear SpellRare
        " highlight SpellRare term=underline cterm=underline
        " highlight clear SpellLocal
        " highlight SpellLocal term=underline cterm=underline
    ]])
end

local function setup()
    set_global_variables()
    set_common_keymaps()
    set_options()
    set_cursor_line()
    set_misc_autocmds()

    require('pluginloader')

    -- local colorscheme = opts.colorscheme or {}
    -- set_colorscheme(colorscheme.name, colorscheme.background)
end

return {
    setup = setup,
}
