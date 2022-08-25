local package = { -- For 'wbthomason/packer.nvim'
    'olexsmir/gopher.nvim', ft = { 'go' },
    cmd = { 'GoInstallDeps', 'GoTagAdd', 'GoTagRm', 'GoTestAdd', 'GoGet', 'GoTestsExp' },
    event = { "BufReadPost", "BufNewFile" },
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}

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

return {
    package = package,
    config = config,
}
