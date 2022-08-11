local package = { -- For 'wbthomason/packer.nvim'
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    requires = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'p00f/nvim-ts-rainbow' },
    },
}

-- FIXME: rainbow: https://github.com/p00f/nvim-ts-rainbow/issues/110

local config = function()
    require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = {
            "c", "cmake", "bash", "go",
            "javascript", "json", "json5", "lua", "markdown",
            "proto", "python", "rust", "sql", "toml",
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
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = { html = true }, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = 2300, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        }
    })
end


return {
    package = package,
    config = config,
}
