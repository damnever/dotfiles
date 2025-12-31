local config = function()
	require("lib").vimbatch.global_vars({
		undotree_SetFocusWhenToggle = 1,
	})
end

return { {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	config = config,
} }
