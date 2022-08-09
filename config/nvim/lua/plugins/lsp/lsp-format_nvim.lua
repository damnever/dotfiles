local package = { -- For 'wbthomason/packer.nvim'
    'lukas-reineke/lsp-format.nvim',
}

local config = function()
    require("lsp-format").setup({
        exclude = {},
        sync = false,
        force = false,
        -- These settings depends on lsp.
        -- yaml = { tab_width = 2 },
        -- json = { tab_width = 2 },
    })
    -- https://github.com/lukas-reineke/lsp-format.nvim#wq-will-not-format-when-not-using-sync
    vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
end


return {
    package = package,
    config = config,
}
