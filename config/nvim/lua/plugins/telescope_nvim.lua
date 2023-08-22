-- For 'wbthomason/packer.nvim'
local package = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-lua/popup.nvim' },
        { 'nvim-telescope/telescope-frecency.nvim', requires = { "tami5/sqlite.lua" } },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { 'AckslD/nvim-neoclip.lua' },
    }
}

local config = function()
    local vim = vim
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    -- Search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- Do nott search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!.git/*")

    telescope.setup {
        defaults = {
            prompt_prefix = " ", -- 
            selection_caret = " ", -- 
            entry_prefix = " ",
            scroll_strategy = "limit",
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            layout_strategy = "horizontal",
            path_display = { "absolute" },
            file_ignore_patterns = {},
            layout_config = {
                prompt_position = "bottom",
                horizontal = {
                    preview_width = 0.5,
                },
            },
            vimgrep_arguments = vimgrep_arguments,
            preview = {
                filesize_limit = 10, -- MB
                timeout = 300, -- ms
                treesitter = true,
                msg_bg_fillchar = "╱",
            },
            mappings = {
            }
        },
        pickers = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        extensions = {
            fzf = {
                fuzzy = false,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
            },
        },
    }

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("frecency")
    require('telescope').load_extension('neoclip')

    require('neoclip').setup({
        history = 1000,
        enable_persistent_history = false,
        length_limit = 1048576,
        continuous_sync = false,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        filter = nil,
        preview = true,
        prompt = nil,
        default_register = '"',
        default_register_macros = 'q',
        enable_macro_history = true,
        content_spec_column = false,
        disable_keycodes_parsing = false,
        on_select = {
            move_to_front = false,
            close_telescope = true,
        },
        on_paste = {
            set_reg = false,
            move_to_front = false,
            close_telescope = true,
        },
        on_replay = {
            set_reg = false,
            move_to_front = false,
            close_telescope = true,
        },
        on_custom_action = {
            close_telescope = true,
        },
        keys = {
            telescope = {
                i = {
                    select = '<cr>',
                    paste = '<s-p>',
                    paste_behind = '<s-k>',
                    replay = '<s-q>', -- replay a macro
                    delete = '<c-d>', -- delete an entry
                    edit = '<c-e>', -- edit an entry
                    custom = {},
                },
                n = {
                    select = '<cr>',
                    paste = 'p',
                    --- It is possible to map to more than one key.
                    -- paste = { 'p', '<c-p>' },
                    paste_behind = 'P',
                    replay = 'q',
                    delete = 'd',
                    edit = 'e',
                    custom = {},
                },
            },
        },
    })


    require('lib').vimbatch.keymaps({
        -- Lists files in your current working directory, respects .gitignore
        { mode = '', lhs = '<leader>p', rhs = function() require('telescope.builtin').find_files() end },
        { mode = '', lhs = '<leader><space>', rhs = function() require('telescope.builtin').find_files() end },
        -- Searches for the string under your cursor in your current working directory.
        { mode = 'v', lhs = '<leader>g', rhs = function() require('telescope.builtin').grep_string() end },
        -- Search for a string in your current working directory and get results live as you type (respecting .gitignore)
        { mode = '', lhs = '<leader>G', rhs = function() require('telescope.builtin').live_grep() end },
        -- Lists normal mode keymappings.
        { mode = '', lhs = '<leader>k', rhs = function() require('telescope.builtin').keymaps() end },
        -- Launch the neoclip(clipboard manager).
        { mode = '', lhs = '<leader>cp', rhs = ':Telescope neoclip<CR>' },
    })
end

return {
    package = package,
    config = config,
}
