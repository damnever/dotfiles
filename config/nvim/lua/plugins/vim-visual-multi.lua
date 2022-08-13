local package = { -- For 'wbthomason/packer.nvim'
    'mg979/vim-visual-multi', branch = 'master',
    event = { "BufReadPost" },
}

return {
    package = package,
    config = config,
}
