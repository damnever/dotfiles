local config = function()
	vim.opt.list = true
	vim.opt.listchars:remove("eol") -- Disable end of line char.

	require("ibl").setup({
		scope = {
			enabled = false,
			show_start = false,
			show_end = false,
		},
	})
end

return { {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost",
	config = config,
} }
