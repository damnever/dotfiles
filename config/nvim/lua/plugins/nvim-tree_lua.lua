local config = function()
    local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings. Feel free to modify or remove as you wish.
        --
        -- BEGIN_DEFAULT_ON_ATTACH
        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
        vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))     -- Default to '<C-v>'
        vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split')) -- Default to '<C-x>'
        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
        vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
        vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
        vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
        vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
        vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
        -- vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
        vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
        vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'r', api.tree.reload, opts('Refresh'))            -- Default to 'R'
        vim.keymap.set('n', 'R', api.fs.rename, opts('Rename'))               -- Default to 'r'
        vim.keymap.set('n', '<C-s>', api.node.run.system, opts('Run System')) -- Default ot 's'
        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
        vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        -- vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        -- vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        -- END_DEFAULT_ON_ATTACH


        -- Mappings removed via:
        --   remove_keymaps
        --   OR
        --   view.mappings.list..action = ""
        --
        -- The dummy set before del is done for safety, in case a default mapping does not exist.
        --
        -- You might tidy things by removing these along with their default mapping.
        vim.keymap.set('n', 'O', '', { buffer = bufnr })
        vim.keymap.del('n', 'O', { buffer = bufnr })
        vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
        vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
        vim.keymap.set('n', 'D', '', { buffer = bufnr })
        vim.keymap.del('n', 'D', { buffer = bufnr })
        vim.keymap.set('n', 'E', '', { buffer = bufnr })
        vim.keymap.del('n', 'E', { buffer = bufnr })


        -- Mappings migrated from view.mappings.list
        --
        -- You will need to insert "your code goes here" for any mappings with a custom action_cb
        vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', 'P', function()
            local node = api.tree.get_node_under_cursor()
            print(node.absolute_path)
        end, opts('Print Node Path'))

        vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
    end

    require("nvim-tree").setup({
        tab = {
            sync = {
                open = false,
            }
        },
        auto_reload_on_write = false,
        hijack_cursor = false,
        sort_by = "case_sensitive",
        filesystem_watchers = {
            enable = true,
            debounce_delay = 1234, -- ms
            ignore_dirs = {
                'node_modules',
                'vendor',
            },
        },
        renderer = {
            group_empty = true,
            hidden_display = function(hidden_stats) -- or "simple", "all"
                local total_count = 0
                local status = ""
                for reason, count in pairs(hidden_stats) do
                    if count > 0 then
                        status = status .. (total_count > 0 and ", " or "") .. reason .. ":" .. tostring(count)
                    end
                    total_count = total_count + count
                end

                if total_count > 0 then
                    return " " .. tostring(total_count) .. " hidden (" .. status .. ")"
                end
                return nil
            end,
            icons = {
                git_placement = "before", -- right_align
                modified_placement = "after",
                hidden_placement = "after",
                diagnostics_placement = "signcolumn",
                bookmarks_placement = "signcolumn",
                glyphs = {
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "",
                    },
                },
            },
        },
        update_focused_file = {
            enable = true,
            update_root = {
                enable = false,
                ignore_list = {},
            },
            exclude = false,
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
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
            ignore = false,
        },
        modified = {
            enable = false,
        },
        view = {
            adaptive_size = false,
            width = 33,
            side = "left",
        },
        on_attach = on_attach,
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
            if not vim.tbl_isempty(tab_bufs) then      -- and was not the last window (not closed automatically by code below)
                api.tree.close()
            end
        else                                                          -- else closed buffer was normal buffer
            if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
                local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
                if last_buf_info.name:match(".*NvimTree_%d*$") then   -- and that buffer is nvim tree
                    vim.schedule(function()
                        if #vim.api.nvim_list_wins() == 1 then        -- if its the last buffer in vim
                            vim.cmd "quit"                            -- then close all of vim
                        else                                          -- else there are more tabs open
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


return { {
    'nvim-tree/nvim-tree.lua',
    dependencies = { { 'kyazdani42/nvim-web-devicons' }, },
    config       = config,
    enabled      = false,
} }
