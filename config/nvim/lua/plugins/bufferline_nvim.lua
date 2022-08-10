local package = { -- For 'wbthomason/packer.nvim'
    'akinsho/bufferline.nvim', tag = "v2.*", disable = true,
    requires = { { 'tiagovla/scope.nvim' }, { 'kyazdani42/nvim-web-devicons' }, },
}

local config = function()
    require("bufferline").setup({
        options = {
            mode = 'tabs', -- 'buffers'
            numbers = 'ordinal', -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
            max_name_length = 23,
            diagnostics = false,
        },
    })
    require("scope").setup()
end


return {
    package = package,
    config = config,
}