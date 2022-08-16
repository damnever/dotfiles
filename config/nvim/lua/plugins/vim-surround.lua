local package = { -- For 'wbthomason/packer.nvim'
    'tpope/vim-surround',
    event = { "BufReadPost", "BufNewFile" },
}

return {
    package = package,
    config = config,
}
