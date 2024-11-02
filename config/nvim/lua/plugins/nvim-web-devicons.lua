local config = function()
    require('nvim-web-devicons').setup({
        override = {},
        default = false,
    })
end

return { {
    'kyazdani42/nvim-web-devicons',
    config = config,
} }
