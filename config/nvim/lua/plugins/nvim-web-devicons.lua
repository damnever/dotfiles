local config = function()
    require('nvim-web-devicons').setup({
        override = {},
        default = false,
    })
end

return { {
    'nvim-tree/nvim-web-devicons',
    config = config,
} }
