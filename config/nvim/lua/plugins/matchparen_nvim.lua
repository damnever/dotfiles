local config = function()
	require("matchparen").setup({
		enabled = true,
		hl_group = "MatchParen",
	})
end

return { {
	"monkoose/matchparen.nvim",
	config = config,
} }
