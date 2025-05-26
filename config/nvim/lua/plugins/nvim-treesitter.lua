local treesitter_config = function()
    require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = {
            "bash", "c", "cmake", "commonlisp",
            "go", "gomod", "gowork",
            "html", "javascript", "json5",
            "make", "markdown",
            "proto", "python",
            "rust", "rst", "sql", "swift", "toml",
            "vim", "yaml"
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        -- List of parsers to ignore installing (for "all")
        ignore_install = {},
        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = {},
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local max_filesize = 2 * 1024 * 1024 -- 2 MiB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
            disable = {},
        },
        autopairs = {
            disable = {},
            enable = true
        },
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                }
            },
        },
        -- rainbow = {
        -- enable = true,
        -- disable = { "dockerfile" }, -- list of languages you want to disable the plugin for
        -- extended_mode = { html = true }, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        -- max_file_lines = 2300, -- Do not enable for files with more than n lines, int
        -- -- colors = {}, -- table of hex strings
        -- -- termcolors = {} -- table of colour name strings
        -- },
        modules = {}
    })
end

local treesitter_context_config = function()
    require('treesitter-context').setup({
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false,      -- Enable multiwindow support.
        max_lines = 2,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 35,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 10, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    })

    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { bg = 'NONE', fg = '#F2FAFA' })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { bg = 'NONE', fg = '#F2FAFA' })
end

local rainbow_delimiters_config = function()
    require('rainbow-delimiters.setup').setup {
        strategy = {
            [''] = require("rainbow-delimiters.strategy.global"),
            vim = require("rainbow-delimiters.strategy.local"),
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        priority = {
            [''] = 110,
            lua = 210,
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterGreen',
            'RainbowDelimiterOrange',
            'RainbowDelimiterCyan',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterViolet',
        },
    }
end

local auto_tag_config = function()
    require('nvim-ts-autotag').setup({
        opts = {
            -- Defaults
            enable_close = true,         -- Auto close tags
            enable_rename = true,        -- Auto rename pairs of tags
            enable_close_on_slash = true -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {}
    })
end


return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = '*',
        build = ":TSUpdate",
        config = treesitter_config,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = treesitter_context_config,
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        config = rainbow_delimiters_config,
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    {
        'windwp/nvim-ts-autotag',
        config = auto_tag_config,
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
}