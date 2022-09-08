local package = { -- For 'wbthomason/packer.nvim'
    'nvim-treesitter/nvim-treesitter',
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    requires = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        -- { 'p00f/nvim-ts-rainbow' },
    },
}

-- FIXME: rainbow: https://github.com/p00f/nvim-ts-rainbow/issues/110

local config = function()
    require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = {
            "bash", "c", "cmake", "go", "gomod", "gowork",
            "html", "javascript", "json5", "make", "markdown",
            "proto", "python", "rust", "rst", "sql", "toml",
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
            disable = {},

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
            disable = { "python" }, -- hynek/vim-python-pep8-indent
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
        context_commentstring = {
            enable = true,
            config = {
                go = '// %s',
                python = '# %s',
            }
        }
        -- rainbow = {
        -- enable = true,
        -- disable = { "dockerfile" }, -- list of languages you want to disable the plugin for
        -- extended_mode = { html = true }, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        -- max_file_lines = 2300, -- Do not enable for files with more than n lines, int
        -- -- colors = {}, -- table of hex strings
        -- -- termcolors = {} -- table of colour name strings
        -- },
    })
end


return {
    package = package,
    config = config,
}
