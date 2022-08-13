local package = { -- For 'wbthomason/packer.nvim'
    'tpope/vim-surround',
    event = { "BufReadPost" },
}

return {
    package = package,
    config = config,
}
