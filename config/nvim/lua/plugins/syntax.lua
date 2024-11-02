local config = function()
    require('lib').vimbatch.global_vars({
        vim_markdown_folding_disabled = 1,
    })
end

return {
    { 'tmux-plugins/vim-tmux', ft = { 'tmux' } },
    { 'solarnz/thrift.vim', ft = { 'thrift' } },
    { 'fatih/vim-nginx', ft = { 'nginx' } },
    -- { 'plasticboy/vim-markdown', ft = { 'markdown' }, config = config, },
    { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } },
}
