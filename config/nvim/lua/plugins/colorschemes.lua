local nightfox_config = function()
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

local tokyonight_config = function()
    require("tokyonight").setup({
        style = "moon", -- storm
        light_style = "day",
        day_brightness = 0.4,
    })
    vim.o.background = 'dark'
    vim.cmd([[colorscheme tokyonight-storm]])
end

local github_config = function()
    require('github-theme').setup({
        compile_path = vim.fn.stdpath('cache') .. '/github-theme',
        options = {
            transparent = false,
        },
    })

    -- github_dark_dimmed github_dark_default github_dark github_dark_high_contrast github_dark_colorblind
    vim.cmd('colorscheme github_dark_high_contrast')
end

return {
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = nightfox_config,
        enabled = false,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = tokyonight_config,
        enabled = false,
    },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,
        priority = 1000,
        config = github_config,
        enabled = true,
    },
}
