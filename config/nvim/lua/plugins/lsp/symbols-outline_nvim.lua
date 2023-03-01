local package = { -- For 'wbthomason/packer.nvim'
    'simrat39/symbols-outline.nvim',
}

local config = function()
    require("symbols-outline").setup({
        relative_width = true,
        width = 25,
    })

    local vimbatch = require('lib').vimbatch
    vimbatch.keymaps({
        { mode = 'n', lhs = '&lt;leader&gt;b', rhs = ':SymbolsOutline&lt;CR&gt;', opts = { remap = true } },
    })
end

return {
    package = package,
    config = config,
}
