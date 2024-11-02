local config = function()
    require("gopher").setup {
        commands = {
            go = "go",
            gomodifytags = "gomodifytags",
            gotests = "gotests",
            impl = "impl",
            iferr = "iferr",
        },
    }
end

return { {
    'olexsmir/gopher.nvim',
    ft = { 'go' },
    cmd = { 'GoInstallDeps', 'GoTagAdd', 'GoTagRm', 'GoTestAdd', 'GoGet', 'GoTestsExp' },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = config,
} }
