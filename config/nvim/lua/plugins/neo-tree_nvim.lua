local config = function()
	require("neo-tree").setup({
		-- If a user has a sources list it will replace this one.
		-- Only sources listed here will be loaded.
		-- You can also add an external source by adding it's name to this list.
		-- The name used here must be the same name you would use in a require() call.
		sources = {
			"filesystem",
			"buffers",
			"git_status",
			-- "document_symbols",
		},
		auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		default_source = "filesystem", -- you can choose a specific source `last` here which indicates the last used source
		enable_diagnostics = false,
		enable_git_status = true,
		enable_modified_markers = true, -- Show markers for files with unsaved changes.
		enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
		enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
		enable_cursor_hijack = false, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
		git_status_async = true,
		-- These options are for people with VERY large git repos
		git_status_async_options = {
			batch_size = 1000, -- how many lines of git status results to process at a time
			batch_delay = 10, -- delay in ms between batches. Spreads out the workload to let other processes run.
			max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
			-- Anything before this will be used. The last items to be processed are the untracked files.
		},
		hide_root_node = false, -- Hide the root node.
		retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
		log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
		log_to_file = false, -- true, false, "/path/to/file.log", use ':lua require("neo-tree").show_logs()' to show the file
		open_files_in_last_window = true, -- false = open files in top left window
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" }, -- when opening files, do not use windows containing these filetypes or buftypes
		open_files_using_relative_paths = false,
		-- popup_border_style is for input and confirmation dialogs.
		-- Configurtaion of floating window is done in the individual source sections.
		-- "NC" is a special style that works well with NormalNC set
		resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
		use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
		use_default_mappings = false,
		-- source_selector provides clickable tabs to switch between sources.
		default_component_configs = {
			container = {
				enable_character_fade = true,
				width = "100%",
				right_padding = 0,
			},
			icon = {
				default = "",
			},
			indent = {
				indent_size = 2,
				padding = 1,
				-- indent guides
				with_markers = false,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			modified = {
				symbol = "[+] ",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
				-- Take values in { false (no highlight), true (only loaded),
				-- "all" (both loaded and unloaded)}. For more information,
				-- see the `show_unloaded` config of the `buffers` source.
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					added = "✚", -- NOTE: you can set any of these to an empty string to not show them
					modified = "",
					unstaged = "✗",
					staged = "✓",
					conflict = "",
					unmerged = "",
					renamed = "󰁕",
					untracked = "",
					deleted = "",
					ignored = "",
				},
				align = "right",
			},
			-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
			file_size = {
				enabled = true,
				width = 12, -- width of the column
				required_width = 64, -- min width of window required to show this column
			},
			type = {
				enabled = true,
				width = 10, -- width of the column
				required_width = 110, -- min width of window required to show this column
			},
			last_modified = {
				enabled = true,
				width = 20, -- width of the column
				required_width = 88, -- min width of window required to show this column
				format = "%Y-%m-%d %I:%M %p", -- format string for timestamp (see `:h os.date()`)
				-- or use a function that takes in the date in seconds and returns a string to display
				--format = require("neo-tree.utils").relative_date, -- enable relative timestamps
			},
			created = {
				enabled = false,
				width = 20, -- width of the column
				required_width = 120, -- min width of window required to show this column
				format = "%Y-%m-%d %I:%M %p", -- format string for timestamp (see `:h os.date()`)
				-- or use a function that takes in the date in seconds and returns a string to display
				--format = require("neo-tree.utils").relative_date, -- enable relative timestamps
			},
			symlink_target = {
				enabled = true,
				text_format = " ➛ %s", -- %s will be replaced with the symlink target's path.
			},
		},
		nesting_rules = {},
		window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
			-- possible options. These can also be functions that return these options.
			position = "left", -- left, right, top, bottom, float, current
			width = 40, -- applies to left and right positions
			height = 15, -- applies to top and bottom positions
			auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
			popup = { -- settings that apply to float position only
				size = {
					height = "80%",
					width = "50%",
				},
				position = "50%", -- 50% means center it
				title = function(state) -- format the text that appears at the top of a popup window
					return "Neo-tree " .. state.name:gsub("^%l", string.upper)
				end,
				-- you can also specify border here, if you want a different setting from
				-- the global popup_border_style.
			},
			same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
			insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
			-- "child":   Insert nodes as children of the directory under cursor.
			-- "sibling": Insert nodes  as siblings of the directory under cursor.
			-- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
			-- You can also create your own commands by providing a function instead of a string.
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<space>"] = {
					"toggle_node",
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
				},
				["<cr>"] = "open",
				["o"] = "open",
				["<esc>"] = "cancel", -- close preview or floating neo-tree window
				["P"] = {
					"toggle_preview",
					config = {
						use_float = true,
						use_image_nvim = false,
						-- title = "Neo-tree Preview", -- You can define a custom title for the preview floating window.
					},
				},
				["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
				["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
				["l"] = "focus_preview",
				["s"] = "split_with_window_picker",
				["S"] = "vsplit_with_window_picker",
				["<C-s>"] = "split_with_window_picker",
				["<C-v>"] = "vsplit_with_window_picker",
				["t"] = "open_tabnew",
				-- ["t"] = "open_tab_drop",
				-- ["w"] = "open_with_window_picker",
				["C"] = "close_all_nodes",
				["Z"] = "expand_all_nodes",
				["R"] = "refresh",
				["a"] = {
					"add",
					config = {
						show_path = "relative", -- "none", "relative", "absolute"
					},
				},
				["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
				["d"] = "delete",
				["r"] = "rename",
				["Y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
				["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
				["e"] = "toggle_auto_expand_width",
				["q"] = "close_window",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
			},
		},
		filesystem = {
			window = {
				mappings = {
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["D"] = "fuzzy_finder_directory",
					--["/"] = "filter_as_you_type", -- this was the default until v1.28
					["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
					-- ["D"] = "fuzzy_sorter_directory",
					["f"] = "filter_on_submit",
					["<C-x>"] = "clear_filter",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
					["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
					["B"] = "rename_basename",
					["?"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["Oc"] = { "order_by_created", nowait = false },
					["Od"] = { "order_by_diagnostics", nowait = false },
					["Og"] = { "order_by_git_status", nowait = false },
					["Om"] = { "order_by_modified", nowait = false },
					["On"] = { "order_by_name", nowait = false },
					["Os"] = { "order_by_size", nowait = false },
					["Ot"] = { "order_by_type", nowait = false },
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<down>"] = "move_cursor_down",
					["<C-n>"] = "move_cursor_down",
					["<up>"] = "move_cursor_up",
					["<C-p>"] = "move_cursor_up",
					["<esc>"] = "close",
				},
			},
			async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
			-- "always" means directory scans are always async.
			-- "never"  means directory scans are never async.
			scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
			-- "deep": Scan into directories to detect empty or grouped empty directories a priori.
			bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
			cwd_target = {
				sidebar = "tab", -- sidebar is when position = left or right
				current = "window", -- current is when position = current
			},
			check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
			-- setting this to false will speed up searches, but gitignored
			-- items won't be marked if they are visible.
			-- The renderer section provides the renderers that will be used to render the tree.
			--   The first level is the node type.
			--   For each node type, you can specify a list of components to render.
			--       Components are rendered in the order they are specified.
			--         The first field in each component is the name of the function to call.
			--         The rest of the fields are passed to the function as the "config" argument.
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
				show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {
					".DS_Store",
					"thumbs.db",
					"node_modules",
					".venv",
				},
				hide_by_pattern = { -- uses glob style patterns
					--"*.meta",
					--"*/src/*/tsconfig.json"
				},
				always_show = {},
				always_show_by_pattern = { -- uses glob style patterns
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					--".DS_Store",
					--"thumbs.db"
				},
				never_show_by_pattern = { -- uses glob style patterns
					--".null-ls_*",
				},
			},
			find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			search_limit = 50, -- max number of search results when using filters
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",-- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
		},
		buffers = {
			bind_to_cwd = true,
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--              -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			group_empty_dirs = true, -- when true, empty directories will be grouped together
			show_unloaded = false, -- When working with sessions, for example, restored but unfocused buffers
			-- are mark as "unloaded". Turn this on to view these unloaded buffer.
			terminals_first = false, -- when true, terminals will be listed before file buffers
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["d"] = "buffer_delete",
					["bd"] = "buffer_delete",
					["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
					["b"] = "rename_basename",
					["?"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["Oc"] = { "order_by_created", nowait = false },
					["Od"] = { "order_by_diagnostics", nowait = false },
					["Om"] = { "order_by_modified", nowait = false },
					["On"] = { "order_by_name", nowait = false },
					["Os"] = { "order_by_size", nowait = false },
					["Ot"] = { "order_by_type", nowait = false },
				},
			},
		},
		git_status = {
			window = {
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_commit_and_push",
					["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
					["b"] = "rename_basename",
					["?"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["Oc"] = { "order_by_created", nowait = false },
					["Od"] = { "order_by_diagnostics", nowait = false },
					["Om"] = { "order_by_modified", nowait = false },
					["On"] = { "order_by_name", nowait = false },
					["Os"] = { "order_by_size", nowait = false },
					["Ot"] = { "order_by_type", nowait = false },
				},
			},
		},
	})

	local vimbatch = require("lib").vimbatch
	vimbatch.keymaps({
		{ mode = "n", lhs = "<leader>n", rhs = ":Neotree toggle<CR>", opts = { remap = true } },
	})
end

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = config,
		enabled = true,
	},
}
