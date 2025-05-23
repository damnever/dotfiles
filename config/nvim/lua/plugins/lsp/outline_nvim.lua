local config = function()
    require("outline").setup({
        outline_window = {
            relative_width = true,
            width = 25,
        },
    })

    local vimbatch = require('lib').vimbatch
    vimbatch.keymaps({
        { mode = 'n', lhs = '<leader>s', rhs = ':Outline<CR>', opts = { remap = true } },
    })
end

return { {
    'hedyhli/outline.nvim', -- fork of symbols-outline.nvim
    config = config,
} }