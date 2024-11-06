local config = function()
    require('lib').vimbatch.global_vars({
        fugitive_no_maps = 1,
    })
end

return { {
    'tpope/vim-fugitive',
    config = config,
} }
