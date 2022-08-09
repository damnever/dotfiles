local package = { -- For 'wbthomason/packer.nvim'
  'kyazdani42/nvim-tree.lua',
  requires = { { 'kyazdani42/nvim-web-devicons' }, },
}

local config = function()
  require("nvim-tree").setup({
    auto_reload_on_write = false,
    hijack_cursor = true,
    sort_by = "case_sensitive",
    view = {
      adaptive_size = false,
      width = 30,
      height = 30,
      side = "left",
      mappings = {
        custom_only = true,
        list = {
          { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
          { key = "<C-e>", action = "edit_in_place" },
          { key = "O", action = "edit_no_picker" },
          { key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
          { key = "v", action = "vsplit" }, -- <C-v>
          { key = "s", action = "split" }, -- <C-s>
          { key = "<C-t>", action = "tabnew" },
          { key = "<", action = "prev_sibling" },
          { key = ">", action = "next_sibling" },
          { key = "P", action = "parent_node" },
          { key = "<BS>", action = "close_node" },
          { key = "<Tab>", action = "preview" },
          { key = "K", action = "first_sibling" },
          { key = "J", action = "last_sibling" },
          { key = "I", action = "toggle_git_ignored" },
          -- { key = "H", action = "toggle_dotfiles" },
          { key = "U", action = "toggle_custom" },
          { key = "r", action = "refresh" },
          { key = "a", action = "create" },
          { key = "d", action = "remove" },
          { key = "D", action = "trash" },
          -- { key = "r", action = "rename" },
          { key = "<C-r>", action = "full_rename" },
          { key = "x", action = "cut" },
          { key = "c", action = "copy" },
          { key = "p", action = "paste" },
          { key = "y", action = "copy_name" },
          { key = "Y", action = "copy_path" },
          { key = "gy", action = "copy_absolute_path" },
          { key = "[e", action = "prev_diag_item" },
          { key = "[c", action = "prev_git_item" },
          { key = "]e", action = "next_diag_item" },
          { key = "]c", action = "next_git_item" },
          { key = "-", action = "dir_up" },
          { key = "<C-s>", action = "system_open" }, -- s
          { key = "f", action = "live_filter" },
          { key = "F", action = "clear_live_filter" },
          { key = "q", action = "close" },
          { key = "W", action = "collapse_all" },
          { key = "E", action = "expand_all" },
          { key = "S", action = "search_node" },
          { key = ".", action = "run_file_command" },
          { key = "<C-k>", action = "toggle_file_info" },
          { key = "g?", action = "toggle_help" },
          { key = "m", action = "toggle_mark" },
          { key = "bmv", action = "bulk_move" },
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
    -- actions = { expand_all = { exclude = { '.git', '__pycache__', '.svn', '.hg'}, }, },
  })

  local vimbatch = require('lib').vimbatch
  vimbatch.keymaps({
    { mode = 'n', lhs = '<leader>n', rhs = ':NvimTreeToggle<CR>', opts = { remap = true } },
  })

end


return {
  package = package,
  config = config,
}
