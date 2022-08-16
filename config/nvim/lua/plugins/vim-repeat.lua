local package = { -- For 'wbthomason/packer.nvim'
    'tpope/vim-repeat',
    event = { "BufReadPost", "BufNewFile" },
}

return {
    package = package,
    config = config,
}
