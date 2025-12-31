local config = function()
	require("lib").vimbatch.global_vars({
		copilot_enabled = false,
		copilot_no_tab_map = true,
	})

	require("lib").vimbatch.keymaps({
		{
			mode = "i",
			lhs = "<C-J>",
			rhs = 'copilot#Accept("\\<CR>")',
			opts = {
				expr = true,
				replace_keycodes = false,
			},
		},
		{
			mode = "i",
			lhs = "<C-;>",
			rhs = "<Plug>(copilot-next)",
		},
		{
			mode = "i",
			lhs = "<C-'>",
			rhs = "<Plug>(copilot-previous)",
		},
		{
			mode = "i",
			lhs = "<C-S>",
			rhs = "<Plug>(copilot-suggest)",
		},
	})
end

return {
	{
		"github/copilot.vim",
		event = { "BufReadPost" },
		config = config,
		enabled = vim.fn.has("nvim-0.12") == 0,
	},
}
