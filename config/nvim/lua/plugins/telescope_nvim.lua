local config = function()
	local vim = vim
	local telescope = require("telescope")
	local telescope_config = require("telescope.config")
	local actions = require("telescope.actions")
	local action_set = require("telescope.actions.set")
	local action_state = require("telescope.actions.state")

	-- Clone the default Telescope configuration
	local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
	-- Search in hidden/dot files.
	table.insert(vimgrep_arguments, "--hidden")
	-- Do nott search in the `.git` directory.
	table.insert(vimgrep_arguments, "--glob")
	table.insert(vimgrep_arguments, "!.git/*")

	telescope.setup({
		defaults = {
			prompt_prefix = " ", -- 
			selection_caret = " ", -- 
			entry_prefix = " ",
			scroll_strategy = "limit",
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			layout_strategy = "flex",
			path_display = { truncate = 3 },
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
				i = {
					-- ["<esc>"] = actions.close,
					["<C-s>"] = actions.select_horizontal, -- your custom horizontal split
					["<C-v>"] = actions.select_vertical, -- vertical split
					["<C-c>"] = function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "tn", true)
					end,
					["<C-g>"] = function(prompt_bufnr)
						-- Ref: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#using-nvim-window-picker-to-choose-a-target-window-when-opening-a-file-from-any-picker
						-- Use nvim-window-picker to choose the window by dynamically attaching a function
						local picker = action_state.get_current_picker(prompt_bufnr)
						picker.get_selection_window = function(picker, entry)
							local picked_window_id = require("window-picker").pick_window()
								or vim.api.nvim_get_current_win()
							-- Unbind after using so next instance of the picker acts normally
							picker.get_selection_window = nil
							return picked_window_id
						end

						return action_set.edit(prompt_bufnr, "edit")
					end,
					["<c-t>"] = function(prompt_bufnr)
						return require("trouble.sources.telescope").open(prompt_bufnr)
					end,
				},
				n = {
					["s"] = actions.select_horizontal,
					["v"] = actions.select_vertical,
					["<esc>"] = actions.close,
					["<c-t>"] = function(prompt_bufnr)
						return require("trouble.sources.telescope").open(prompt_bufnr)
					end,
				},
			},
		},
		pickers = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
			-- find_files = { mappings = { i = { }, }, },
			commands = {
				mappings = {
					i = {
						-- Set a value in the command line and run it (modified version of actions.set_command_line).
						["<C-r>"] = function(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							if selection == nil then
								return
							end
							actions.close(prompt_bufnr)
							vim.fn.histadd("cmd", selection.name)
							vim.cmd(selection.name)
						end,
					},
				},
			},
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
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("frecency")
	require("telescope").load_extension("neoclip")
	require("telescope").load_extension("ui-select")

	require("neoclip").setup({
		history = 1000,
		enable_persistent_history = false,
		length_limit = 1048576,
		continuous_sync = false,
		db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
		filter = nil,
		preview = true,
		prompt = nil,
		default_register = '"',
		default_register_macros = "q",
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
					select = "<cr>",
					paste = "<s-p>",
					paste_behind = "<s-k>",
					replay = "<s-q>", -- replay a macro
					delete = "<c-d>", -- delete an entry
					edit = "<c-e>", -- edit an entry
					custom = {},
				},
				n = {
					select = "<cr>",
					paste = "p",
					--- It is possible to map to more than one key.
					-- paste = { 'p', '<c-p>' },
					paste_behind = "P",
					replay = "q",
					delete = "d",
					edit = "e",
					custom = {},
				},
			},
		},
	})

	local builtin = require("telescope.builtin")
	require("lib").vimbatch.keymaps({
		-- Lists available plugin/user commands and runs them on `<cr>`
		{ mode = "", lhs = "<leader><space>", rhs = builtin.commands },
		-- { mode = '', lhs = '<leader><space>', rhs = ':Telescope<CR>' },
		-- Lists files in your current working directory, respects .gitignore
		{ mode = "", lhs = "<leader>p", rhs = builtin.find_files },
		-- Searches for the string under your cursor in your current working directory.
		{ mode = "v", lhs = "<leader>g", rhs = builtin.grep_string },
		-- Search for a string in your current working directory and get results live as you type (respecting .gitignore)
		{ mode = "", lhs = "<leader>G", rhs = builtin.live_grep },
		-- Lists commands that were executed recently, and reruns them on <cr>.
		{ mode = "", lhs = "<leader>h", rhs = builtin.command_history },
		-- Lists normal mode keymappings.
		{ mode = "", lhs = "<leader>k", rhs = builtin.keymaps },
		-- Launch the neoclip(clipboard manager).
		{ mode = "", lhs = "<leader>cp", rhs = ":Telescope neoclip<CR>" },
	})
end

return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.2.0",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "tami5/sqlite.lua" } },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "AckslD/nvim-neoclip.lua" },
			{ "folke/trouble.nvim" },
		},
		config = config,
	},
}
