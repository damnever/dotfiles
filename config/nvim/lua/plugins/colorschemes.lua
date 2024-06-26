local package = { -- For 'wbthomason/packer.nvim'
    "EdenEast/nightfox.nvim",
    requires = {
        -- { 'folke/tokyonight.nvim' },
        -- { "catppuccin/nvim", as = "catppuccin" },
        -- { "svrana/neosolarized.nvim", requires = { "tjdevries/colorbuddy.nvim" } },
        -- { 'tomasr/molokai' },
    }
}

local config = function()
    local vim = vim

    require('lib').vimbatch.global_vars({
        -- molokai_original = 1,
        -- rehash256 = 1,
    })
    -- https://github.com/EdenEast/nightfox.nvim/wiki/Gallery : nightfox/nordfox, etc.
    require('nightfox').setup({
        options = {
            compile_path = vim.fn.stdpath("cache") .. "/nightfox",
            compile_file_suffix = "_compiled", -- Compiled file suffix
            transparent = false,               -- Disable setting background
            terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
            dim_inactive = false,              -- Non focused panes set to alternative background
            styles = {                         -- Style to be applied to different syntax groups
                comments = "NONE",             -- Value is any valid attr-list value `:help attr-list`
                conditionals = "NONE",
                constants = "NONE",
                functions = "NONE",
                keywords = "NONE",
                numbers = "NONE",
                operators = "NONE",
                strings = "NONE",
                types = "NONE",
                variables = "NONE",
            },
            inverse = { -- Inverse highlight for different types
                match_paren = false,
                visual = false,
                search = false,
            },
            modules = { -- List of various plugins and additional options
            },
        },
        palettes = {
            carbonfox = {
                sel0 = "#525253", -- Popup bg, visual selection bg
                sel1 = "#003366", -- Popup sel bg, search bg
            }
        },
        specs = {},
        groups = {},
    })

    --[[
    require('neosolarized').setup({
        comment_italics = true,
    })
    ]]
    --

    vim.o.background = 'dark'
    -- nightfox
    vim.cmd([[colorscheme carbonfox]])
end

return {
    package = package,
    config = config,
}
