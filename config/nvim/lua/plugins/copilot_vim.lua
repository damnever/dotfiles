local config = function()
    require('lib').vimbatch.global_vars({
        copilot_enabled = false,
        copilot_no_tab_map = true,
    })

    require('lib').vimbatch.keymaps({
        {
            mode = 'i',
            lhs = '<C-J>',
            rhs = 'copilot#Accept("\\<CR>")',
            opts = {
                expr = true,
                replace_keycodes = false
            },
        }
    })
end

return { {
    'github/copilot.vim',
    event = { "BufReadPost" },
    config = config,
} }
