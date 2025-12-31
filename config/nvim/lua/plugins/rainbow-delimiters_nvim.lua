local config = function()
	require("rainbow-delimiters.setup").setup({
		strategy = {
			[""] = require("rainbow-delimiters.strategy.global"),
			vim = require("rainbow-delimiters.strategy.local"),
		},
		query = {
			[""] = "rainbow-delimiters",
			lua = "rainbow-blocks",
		},
		priority = {
			[""] = 110,
			lua = 210,
		},
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterGreen",
			"RainbowDelimiterOrange",
			"RainbowDelimiterCyan",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterViolet",
		},
	})
end

return { {
	"HiPhish/rainbow-delimiters.nvim",
	config = config,
	enabled = true,
} }
