local config = function()
	local vim = vim
	local telescope = require("telescope")
	local telescope_config = require("telescope.config")
	local actions = require("telescope.actions")
	local action_set = require("telescope.actions.set")
	local action_state = require("telescope.actions.state")
	local livegrepargs_actions = require("telescope-live-grep-args.actions")
	local function open_in_trouble(prompt_bufnr)
		return require("trouble.sources.telescope").open(prompt_bufnr)
	end

	-- Clone the default Telescope configuration
	local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
	-- Search in hidden/dot files.
	table.insert(vimgrep_arguments, "--hidden")
	-- Do not search in the `.git` directory.
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
					["<C-u>"] = false,
					["<C-s>"] = {
						actions.select_horizontal,
						type = "action",
						opts = { desc = "Open selection in horizontal split" },
					},
					["<C-v>"] = {
						actions.select_vertical,
						type = "action",
						opts = { desc = "Open selection in vertical split" },
					},
					["<C-c>"] = {
						function()
							vim.api.nvim_feedkeys(
								vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
								"tn",
								true
							)
						end,
						type = "action",
						opts = { desc = "Leave insert mode" },
					},
					["<C-g>"] = {
						function(prompt_bufnr)
							-- Ref: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#using-nvim-window-picker-to-choose-a-target-window-when-opening-a-file-from-any-picker
							local picker = action_state.get_current_picker(prompt_bufnr)
							picker.get_selection_window = function()
								local picked_window_id = require("window-picker").pick_window()
									or vim.api.nvim_get_current_win()
								-- Restore the default selection behavior after one use.
								picker.get_selection_window = nil
								return picked_window_id
							end

							return action_set.edit(prompt_bufnr, "edit")
						end,
						type = "action",
						opts = { desc = "Open selection in chosen window" },
					},
					["<C-t>"] = {
						open_in_trouble,
						type = "action",
						opts = { desc = "Open search results in Trouble" },
					},
				},
				n = {
					["s"] = {
						actions.select_horizontal,
						type = "action",
						opts = { desc = "Open selection in horizontal split" },
					},
					["v"] = {
						actions.select_vertical,
						type = "action",
						opts = { desc = "Open selection in vertical split" },
					},
					["<esc>"] = { actions.close, type = "action", opts = { desc = "Close picker" } },
					["<c-t>"] = {
						open_in_trouble,
						type = "action",
						opts = { desc = "Open search results in Trouble" },
					},
				},
			},
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
			},
			commands = {
				mappings = {
					i = {
						-- Set a value in the command line and run it (modified version of actions.set_command_line).
						["<C-r>"] = {
							function(prompt_bufnr)
								local selection = action_state.get_selected_entry()
								if selection == nil then
									return
								end
								actions.close(prompt_bufnr)
								vim.fn.histadd("cmd", selection.name)
								vim.cmd(selection.name)
							end,
							type = "action",
							opts = { desc = "Run selected command" },
						},
					},
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
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
			live_grep_args = {
				auto_quoting = true,
				mappings = {
					i = {
						["<C-k>"] = {
							livegrepargs_actions.quote_prompt(),
							type = "action",
							opts = { desc = "Quote search prompt" },
						},
						["<C-i>"] = {
							livegrepargs_actions.quote_prompt({ postfix = " --iglob " }),
							type = "action",
							opts = { desc = "Add file glob to search" },
						},
						["<C-f>"] = {
							livegrepargs_actions.to_fuzzy_refine,
							type = "action",
							opts = { desc = "Fuzzy refine search results" },
						},
					},
				},
			},
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("frecency")
	telescope.load_extension("neoclip")
	telescope.load_extension("ui-select")
	telescope.load_extension("live_grep_args")

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
	local extensions = require("telescope").extensions
	local function search_current_buffer_symbols()
		local language = vim.treesitter.language.get_lang(vim.bo.filetype)
		if language then
			local parser_ok, parser_loaded = pcall(vim.treesitter.language.add, language)
			local query_ok, query = pcall(vim.treesitter.query.get, language, "locals")
			if parser_ok and parser_loaded and query_ok and query then
				return builtin.treesitter()
			end
		end

		return builtin.current_buffer_fuzzy_find()
	end

	require("lib").vimbatch.keymaps({
		{ mode = "n", lhs = "<leader><space>", rhs = builtin.commands, opts = { desc = "Search commands" } },
		{
			mode = "n",
			lhs = "<leader>p",
			rhs = builtin.find_files,
			opts = { desc = "Find files in cwd with rg --files" },
		},
		{
			mode = "n",
			lhs = "<leader>P",
			rhs = extensions.frecency.frecency,
			opts = { desc = "Find recent files by frecency" },
		},
		{
			mode = "v",
			lhs = "<leader>g",
			rhs = builtin.grep_string,
			opts = { desc = "Search selected text in cwd with rg" },
		},
		{
			mode = "n",
			lhs = "<leader>G",
			rhs = extensions.live_grep_args.live_grep_args,
			opts = { desc = "Search text in cwd with rg and args" },
		},
		{
			mode = "n",
			lhs = "<leader>B",
			rhs = builtin.current_buffer_fuzzy_find,
			opts = { desc = "Search text in current buffer with fuzzy matching" },
		},
		{
			mode = "n",
			lhs = "<leader>S",
			rhs = search_current_buffer_symbols,
			opts = { desc = "Search current buffer symbols with Treesitter or text fallback" },
		},
		{
			mode = "n",
			lhs = "<leader>h",
			rhs = builtin.command_history,
			opts = { desc = "Search command history" },
		},
		{
			mode = "n",
			lhs = "<leader>k",
			rhs = function()
				builtin.keymaps({
					modes = { "n", "i", "c", "x", "o", "t" },
					show_plug = false,
				})
			end,
			opts = { desc = "Search keymaps in all modes" },
		},
		{
			mode = "n",
			lhs = "<leader>cp",
			rhs = ":Telescope neoclip<CR>",
			opts = { desc = "Search clipboard history" },
		},
	})
end

return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.2.1",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "tami5/sqlite.lua" } },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "AckslD/nvim-neoclip.lua" },
			{ "folke/trouble.nvim" },
		},
		config = config,
	},
}
