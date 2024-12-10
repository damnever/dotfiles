local config = function()
    require("symbols-outline").setup({
        relative_width = true,
        width = 25,
    })

    local vimbatch = require('lib').vimbatch
    vimbatch.keymaps({
        { mode = 'n', lhs = '<leader>s', rhs = ':SymbolsOutline<CR>', opts = { remap = true } },
    })
end

return { {
    'simrat39/symbols-outline.nvim',
    config = config,
} }
