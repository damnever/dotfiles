local package = { -- For 'wbthomason/packer.nvim'
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim', requires = { "tami5/sqlite.lua" } },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  }
}

local config = function()
  local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
      require("telescope.actions.set").select:enhance({
        post = function()
          vim.cmd(":normal! zx")
        end,
      })
      return true
    end,
  }
  require('telescope').setup {
    defaults = {
      prompt_prefix = "  ",
      selection_caret = " ",
      entry_prefix = " ",
      scroll_strategy = "limit",
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      layout_strategy = "horizontal",
      path_display = { "absolute" },
      file_ignore_patterns = {},
      layout_config = {
        prompt_position = "bottom",
        horizontal = {
          preview_width = 0.5,
        },
      },
    },
    pickers = {
      buffers = fixfolds,
      find_files = fixfolds,
      git_files = fixfolds,
      grep_string = fixfolds,
      live_grep = fixfolds,
      oldfiles = fixfolds,
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


  require('lib').vimbatch.keymaps({
    -- Lists files in your current working directory, respects .gitignore
    { mode = '', lhs = '<leader>p', rhs = function() require('telescope.builtin').find_files() end },
    -- Searches for the string under your cursor in your current working directory.
    { mode = 'v', lhs = '<leader>g', rhs = function() require('telescope.builtin').grep_string() end },
    -- Search for a string in your current working directory and get results live as you type (respecting .gitignore)
    { mode = '', lhs = '<leader>G', rhs = function() require('telescope.builtin').live_grep() end },
    -- Lists normal mode keymappings.
    { mode = '', lhs = '<leader>k', rhs = function() require('telescope.builtin').keymaps() end },
  })
end

return {
  package = package,
  config = config,
}
