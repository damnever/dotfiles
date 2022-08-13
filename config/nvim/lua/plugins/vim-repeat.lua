local package = { -- For 'wbthomason/packer.nvim'
    'tpope/vim-repeat',
    event = { "BufReadPost" },
}

return {
    package = package,
    config = config,
}
