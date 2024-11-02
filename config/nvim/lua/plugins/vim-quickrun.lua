local config = function()
    local vimbatch = require('lib').vimbatch
    vimbatch.global_vars({
        quickrun_config = {
            ['_'] = {
                outputter = 'message',
            },
        },
        quickrun_no_default_key_mappings = 1,
    })

    require('lib').vimbatch.keymaps({
        { mode = 'n', lhs = '<leader>r', rhs = '<Plug>(quickrun)', opts = { remap = true } },
    })
end


return { {
    'thinca/vim-quickrun',
    config = config,
} }
