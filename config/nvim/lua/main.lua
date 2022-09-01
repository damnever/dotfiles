local vim = vim
local lib = require('lib')

local function set_global_variables()
    vim.g.mapleader = [[,]]
    vim.g.maplocalleader = [[,]]

    -- This is slow..
    -- local python_bin = vim.fn.substitute(vim.fn.resolve(vim.fn.system('pyenv which python')), '\\n\\+$', '', '')
    -- if string.match(vim.fn.system(python_bin .. ' -V'), '^2%..+') == nil then
    -- else
    -- vim.g.python_host_prog = python_bin
    -- end
    vim.g.python3_host_prog = '/Users/xiaochaodong/.pyenv/shims/python'

    -- Disable builtin plugins.
    local builtin_plugins = {
        'gzip', 'man', 'matchparen', 'matchit', 'netrwPlugin',
        'shada', 'tarPlugin', 'tohtml',
        'tutor', 'zipPlugin',
    }
    for _, plugin in ipairs(builtin_plugins) do
        vim.g['loaded_' .. plugin] = 1
    end
end

local function set_common_keymaps()
    vim.keymap.set('i', '<C-c>', '<ESC>')
    vim.keymap.set('n', '<leader>q', ':q<CR>')
    vim.keymap.set('n', '<leader>w', ':w<CR>')
    vim.keymap.set('n', '<leader>x', ':wq<CR>') -- Tip: Shift + Z Z

    -- Disable direction keys.
    vim.keymap.set('', '<Left>', '<Nop>', { remap = true })
    vim.keymap.set('', '<Right>', '<Nop>', { remap = true })
    vim.keymap.set('', '<Up>', '<Nop>', { remap = true })
    vim.keymap.set('', '<Down>', '<Nop>', { remap = true })

    -- Window movement.
    vim.keymap.set('', '<C-j>', '<C-W>j', { remap = true })
    vim.keymap.set('', '<C-k>', '<C-W>k', { remap = true })
    vim.keymap.set('', '<C-h>', '<C-W>h', { remap = true })
    vim.keymap.set('', '<C-l>', '<C-W>l', { remap = true })

    -- Jump to line start/end.
    vim.keymap.set('', 'H', '^')
    vim.keymap.set('', 'L', '$')

    -- Increase/Decrease number.
    vim.keymap.set('n', '+', '<C-a>')
    vim.keymap.set('n', '-', '<C-x>')

    -- Copy.
    vim.keymap.set('', 'Y', 'y$', { remap = true })
    vim.keymap.set('v', '<leader>y', '"+y"')

    -- Search.
    vim.keymap.set({ 'n', 'v' }, '/', '/\\v')
    vim.keymap.set('', '<leader>/', ':nohls<CR>', { silent = true })

    -- Tab related
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
    vim.api.nvim_create_autocmd("TabLeave", {
        pattern = '*',
        callback = function()
            vim.g.last_active_tab = vim.fn.tabpagenr()
        end,
    })
end

--- :set options
-- vim.api.nvim_set_option(0, k, v) -- vim.o -- global
-- vim.api.nvim_win_set_option(0, k, v) -- vim.wo -- window
-- vim.api.nvim_buf_set_option(0, k, v) -- vim.bo -- bufffer
local function set_options()
    vim.o.smartindent = true
    vim.o.autoindent  = true
    vim.o.tabstop     = 4
    vim.o.shiftwidth  = 4
    vim.o.softtabstop = 4
    vim.o.smarttab    = true
    vim.o.expandtab   = true
    vim.o.shiftround  = true

    vim.o.updatetime = 200 -- Smaller updatetime for CursorHold & CursorHoldI
    vim.o.shortmess = vim.o.shortmess .. 'c'
    vim.o.signcolumn = 'yes'
    vim.o.completeopt = 'menuone,noselect'
    vim.o.list = true
    vim.o.listchars = 'tab:  ,trail:∙,extends:❯,precedes:❮,nbsp:•'
    vim.o.fillchars = vim.o.fillchars .. 'vert:│'

    vim.o.undofile = true
    vim.o.undodir = lib.ensure_data_cache_dir('undo')
    vim.o.history = 2000
    vim.o.autoread = true
    vim.o.backup = false
    vim.o.swapfile = false
    vim.o.wildignorecase = false
    vim.o.wildignore = '*.o,*.out,*.swp,*.bak,*.pyc,*.pyo,__pycache__,*.class,*.beam,.git,.hg,.svn,*.DS_Store'
    vim.o.wildoptions = "pum"

    vim.o.mouse = nil
    vim.o.visualbell = true
    vim.o.errorbells = true
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

    vim.o.fileformats = 'unix,mac,dos'
    vim.o.formatoptions = vim.o.formatoptions .. 'mBw'
    -- vim.o.synmaxcol = 2500
    vim.o.wrap = false

    vim.o.exrc = true
    vim.o.secure = true

    vim.o.winblend = 0
    vim.o.pumblend = 5
    vim.o.termguicolors = true
end

-- TODO: call packer sync manually, ref: ./plugins/colorschemes.lua.
local function set_colorscheme(name, background)
    name = name ~= nil and name or 'molokai'
    background = background ~= nil and background or 'dark'
    vim.o.background = background
    -- opt('t_Co', '256')
    vim.cmd('colorscheme ' .. name)
end

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
    -- Remove trailing whitespaces
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*" },
        command = [[%s/\s\+$//e]],
    })

    -- Auto shebang
    local filetype_shebangs = {
        sh = 'bash',
        py = 'python'
    }
    local function auto_shebang()
        local ext = vim.fn.expand("%:e")
        local shebang = filetype_shebangs[ext]
        if shebang then
            vim.fn.setline(1, '#!/bin/' .. shebang)
            vim.fn.append(1, '')
            vim.fn.cursor(2, 0)
        end
    end

    local patterns = {}
    for ft in pairs(filetype_shebangs) do
        table.insert(patterns, '*.' .. ft)
    end
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = patterns,
        callback = auto_shebang,
    })


    -- Wrap lines for documents
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { 'txt', 'markdown', 'rst', 'asciidoc' },
        command = [[
            setlocal wrap
            setlocal linebreak
            setlocal nolist
        ]],
        -- callback = function()
        -- vim.wo.wrap = true
        -- vim.bo.textwidth = 9999
        -- vim.wo.linebreak = true
        -- vim.wo.nolist = true -- no working!
        -- end,
    })


    -- misc
    -- Ref: https://github.com/neovim/neovim/issues/7994
    vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = '*',
        command = [[set nopaste]]
    })
    vim.cmd([[
        " autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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
