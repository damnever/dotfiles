local package = { -- For 'wbthomason/packer.nvim'
    'preservim/nerdcommenter',
}

local config = function()
    require('lib').vimbatch.global_vars({
        NERDSpaceDelims = 1,
    })
end

return {
    package = package,
    config = config,
}
