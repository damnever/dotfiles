local package = { -- For 'wbthomason/packer.nvim'
    'lukas-reineke/lsp-format.nvim',
}

local config = function()
    local opts = {}
    for _, v in pairs(vim.fn.getcompletion("", "filetype")) do
        opts[v] = {
            exclude = {},
            sync = true,
            force = false,
        }
    end
    require("lsp-format").setup(opts)
    -- https://github.com/lukas-reineke/lsp-format.nvim#wq-will-not-format-when-not-using-sync
    -- vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
end


return {
    package = package,
    config = config,
}
