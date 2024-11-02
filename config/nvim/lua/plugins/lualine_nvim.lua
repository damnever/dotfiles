local config = function()
    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'powerline_dark', -- auto
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { { 'filename', path = 1, } },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = { -- kdheepak/tabline.nvim isn't working: https://github.com/kdheepak/tabline.nvim/issues/44
            lualine_a = {
                {
                    'tabs',
                    -- Maximum width of tabs component.
                    -- Note:
                    -- It can also be a function that returns
                    -- the value of `max_length` dynamically
                    max_length = function() return vim.o.columns / 3 end,
                    -- 0: Shows tab_nr, 1: Shows tab_name, 2: Shows tab_nr + tab_name
                    mode = 2,
                    tabs_color = {
                        -- Same values as the general color option can be used here.
                        -- example: lualine_a_insert / lualine_a_inactive
                        active = 'lualine_a_normal',   -- Color for active tab.
                        inactive = 'lualine_b_normal', -- Color for inactive tab.
                    },
                    fmt = function(label) return ' ' .. label end,
                },
            }
        },
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-tree' }
    })
end


return { {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        -- { 'arkav/lualine-lsp-progress' }, -- See: lsp/fidget_nvim.lua
        { 'kyazdani42/nvim-web-devicons' },
    },
    config = config,
} }
