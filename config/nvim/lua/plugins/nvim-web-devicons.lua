local package = { -- For 'wbthomason/packer.nvim'
    'kyazdani42/nvim-web-devicons',
}

local config = function()
    require('nvim-web-devicons').setup({
        override = {},
        default = false,
    })
end

return {
    package = package,
    config = config,
}
