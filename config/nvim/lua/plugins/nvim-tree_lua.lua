local package = {
    -- For 'wbthomason/packer.nvim'
    'kyazdani42/nvim-tree.lua',
    requires = { { 'kyazdani42/nvim-web-devicons' }, },
}

local config = function()
    require("nvim-tree").setup({
        open_on_tab = false,
        open_on_setup = false, -- Open if startup buffer is a directory.
        open_on_setup_file = false,
        auto_reload_on_write = false,
        hijack_cursor = true,
        sort_by = "case_sensitive",
        filesystem_watchers = {
            enable = true,
            debounce_delay = 1234, -- ms
        },
        view = {
            adaptive_size = false,
            width = 33,
            side = "left",
            mappings = {
                custom_only = true,
                list = {
                    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                    { key = "<C-e>",                          action = "edit_in_place" },
                    { key = "O",                              action = "edit_no_picker" },
                    { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
                    { key = "v",                              action = "vsplit" }, -- <C-v>
                    { key = "s",                              action = "split" }, -- <C-s>
                    { key = "<C-t>",                          action = "tabnew" },
                    { key = "<",                              action = "prev_sibling" },
                    { key = ">",                              action = "next_sibling" },
                    { key = "P",                              action = "parent_node" },
                    { key = "<BS>",                           action = "close_node" },
                    { key = "<Tab>",                          action = "preview" },
                    { key = "K",                              action = "first_sibling" },
                    { key = "J",                              action = "last_sibling" },
                    { key = "I",                              action = "toggle_git_ignored" },
                    -- { key = "H", action = "toggle_dotfiles" },
                    { key = "U",                              action = "toggle_custom" },
                    { key = "r",                              action = "refresh" },
                    { key = "a",                              action = "create" },
                    { key = "d",                              action = "remove" },
                    { key = "D",                              action = "trash" },
                    -- { key = "r", action = "rename" },
                    { key = "<C-r>",                          action = "full_rename" },
                    { key = "x",                              action = "cut" },
                    { key = "c",                              action = "copy" },
                    { key = "p",                              action = "paste" },
                    { key = "y",                              action = "copy_name" },
                    { key = "Y",                              action = "copy_path" },
                    { key = "gy",                             action = "copy_absolute_path" },
                    { key = "[e",                             action = "prev_diag_item" },
                    { key = "[c",                             action = "prev_git_item" },
                    { key = "]e",                             action = "next_diag_item" },
                    { key = "]c",                             action = "next_git_item" },
                    { key = "-",                              action = "dir_up" },
                    { key = "<C-s>",                          action = "system_open" }, -- s
                    { key = "f",                              action = "live_filter" },
                    { key = "F",                              action = "clear_live_filter" },
                    { key = "q",                              action = "close" },
                    { key = "W",                              action = "collapse_all" },
                    { key = "E",                              action = "expand_all" },
                    { key = "S",                              action = "search_node" },
                    { key = ".",                              action = "run_file_command" },
                    { key = "<C-k>",                          action = "toggle_file_info" },
                    { key = "g?",                             action = "toggle_help" },
                    { key = "m",                              action = "toggle_mark" },
                    { key = "bmv",                            action = "bulk_move" },
                },
            },
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false,
            custom = { -- vim regex (|string-match|).
                '\\.pyc$', '\\.pyo$', '\\.egg$', '__pycache__', '\\.beam$',
                '\\.obj$', '\\.o$', '\\.out$', '\\.so$', '\\.test$',
                '^\\.git$', '^\\.svn$', '^\\.hg$',
            },
        },
        git = {
            enable = false,
            ignore = false,
            show_on_dirs = false,
        }
        -- actions = { expand_all = { exclude = { '.git', '__pycache__', '.svn', '.hg'}, }, },
    })

    local vimbatch = require('lib').vimbatch
    vimbatch.keymaps({
        { mode = 'n', lhs = '<leader>n', rhs = ':NvimTreeToggle<CR>', opts = { remap = true } },
    })

    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
    local function tab_win_closed(winnr)
        local api = require "nvim-tree.api"
        local tabnr = vim.api.nvim_win_get_tabpage(winnr)
        local bufnr = vim.api.nvim_win_get_buf(winnr)
        local buf_info = vim.fn.getbufinfo(bufnr)[1]
        local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
        local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
        if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
            -- Close all nvim tree on :q
            if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
                api.tree.close()
            end
        else -- else closed buffer was normal buffer
            if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
                local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
                if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
                    vim.schedule(function()
                        if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
                            vim.cmd "quit" -- then close all of vim
                        else -- else there are more tabs open
                            vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
                        end
                    end)
                end
            end
        end
    end

    vim.api.nvim_create_autocmd("WinClosed", {
        callback = function()
            local winnr = tonumber(vim.fn.expand("<amatch>"))
            vim.schedule_wrap(tab_win_closed(winnr))
        end,
        nested = true
    })
end


return {
    package = package,
    config = config,
}
