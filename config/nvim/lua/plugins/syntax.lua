local package = { -- For 'wbthomason/packer.nvim'
    'tmux-plugins/vim-tmux', ft = { 'tmux' },
    { 'solarnz/thrift.vim', ft = { 'thrift' } },
    { 'kevinoid/vim-jsonc', ft = { 'json', 'jsonc' } },
    { 'ekalinin/Dockerfile.vim', ft = { 'Dockerfile' } },
    { 'fatih/vim-nginx', ft = { 'nginx' } },
    { 'plasticboy/vim-markdown', ft = { 'markdown' } },
}

local config = function()
    require('lib').vimbatch.global_vars({
        vim_markdown_folding_disabled = 1,
    })
end

return {
    package = package,
    config = config,
}
