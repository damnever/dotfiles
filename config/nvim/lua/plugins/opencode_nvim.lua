local config = function()
	---@type opencode.Opts
	vim.g.opencode_opts = {
		-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
		provider = {
			cmd = "opencode --continue",
			-- enabled = "tmux",
			snacks = {
				auto_close = true, -- Close the terminal when `opencode` exits
				win = {
					position = "right",
					enter = true,
					wo = {
						winbar = "", -- Title is unnecessary - `opencode` TUI has its own footer
					},
					bo = {
						-- Make it easier to target for customization, and prevent possibly unintended `"snacks_terminal"` targeting.
						-- e.g. the recommended edgy.nvim integration puts all `"snacks_terminal"` windows at the bottom.
						filetype = "opencode_terminal",
					},
				},
			},
			tmux = {
				options = "-h", -- Open in a horizontal split
			},
		},
	}

	-- Required for `opts.events.reload`.
	vim.o.autoread = true

	-- Recommended/example keymaps.
	vim.keymap.set({ "n", "x" }, "<C-a>", function()
		require("opencode").ask("@this: ", { submit = true })
	end, { desc = "Ask opencode" })
	vim.keymap.set({ "n", "x" }, "<C-x>", function()
		require("opencode").select()
	end, { desc = "Execute opencode action…" })
	vim.keymap.set({ "n", "t" }, "<C-.>", function()
		require("opencode").toggle()
	end, { desc = "Toggle opencode" })

	vim.keymap.set({ "n", "x" }, "go", function()
		return require("opencode").operator("@this ")
	end, { expr = true, desc = "Add range to opencode" })
	vim.keymap.set("n", "goo", function()
		return require("opencode").operator("@this ") .. "_"
	end, { expr = true, desc = "Add line to opencode" })

	vim.keymap.set("n", "<S-C-u>", function()
		require("opencode").command("session.half.page.up")
	end, { desc = "opencode half page up" })
	vim.keymap.set("n", "<S-C-d>", function()
		require("opencode").command("session.half.page.down")
	end, { desc = "opencode half page down" })

	-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
	vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
	vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
end

return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for `snacks` provider.
			---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = config,
	},
}