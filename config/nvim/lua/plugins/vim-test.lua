local config = function()
    require("lib").vimbatch.global_vars({
        ['test#strategy'] = "vimux", -- Runs test commands in a small tmux pane at the bottom of your terminal.
        ['test#preserve_screen'] = 0,
        ['test#echo_command'] = 0,
        ['test#go#gotest#executable'] = 'gotest -v -race -count=1',
    })
end

return { {
    'vim-test/vim-test',
    dependencies = {
        'preservim/vimux',
    },
    config = config,
} }
