local config = function()
	require("hop").setup({
		keys = "qweruiopasdfghjklcn",
	})

	require("lib").vimbatch.keymaps({
		{
			mode = "",
			lhs = "f",
			rhs = function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.AFTER_CURSOR,
					current_line_only = true,
				})
			end,
			opts = { desc = "Find character forward on current line with Hop" },
		},
		{
			mode = "",
			lhs = "F",
			rhs = function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
					current_line_only = true,
				})
			end,
			opts = { desc = "Find character backward on current line with Hop" },
		},
		{
			mode = "",
			lhs = "t",
			rhs = function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.AFTER_CURSOR,
					current_line_only = true,
					hint_offset = -1,
				})
			end,
			opts = { desc = "Find before character forward on current line with Hop" },
		},
		{
			mode = "",
			lhs = "T",
			rhs = function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
					current_line_only = true,
					hint_offset = -1,
				})
			end,
			opts = { desc = "Find after character backward on current line with Hop" },
		},
		{
			mode = "",
			lhs = "<leader><leader>g",
			rhs = function()
					require("hop").hint_lines()
				end,
			opts = { desc = "Find and jump to visible line with Hop" },
		},
		{
			mode = "",
			lhs = "<leader><leader>w",
			rhs = function()
					require("hop").hint_words()
				end,
			opts = { desc = "Find and jump to visible word with Hop" },
		},
	})
end

return { {
	"smoka7/hop.nvim",
	event = "BufReadPost",
	config = config,
} }
