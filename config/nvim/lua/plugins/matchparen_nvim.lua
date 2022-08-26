local package = { -- For 'wbthomason/packer.nvim'
    'monkoose/matchparen.nvim',
}

local config = function()
    require('matchparen').setup({
        on_startup = true, -- Should it be enabled by default
        hl_group = 'MatchParen', -- highlight group for matched characters
        augroup_name = 'matchparen', -- almost no reason to touch this unless there is already augroup with such name
    })
end

return {
    package = package,
    config = config,
}
