local package = { -- For 'wbthomason/packer.nvim'
    'lewis6991/gitsigns.nvim',
}

local config = function()
    require('gitsigns').setup({
        signcolumn      = true,
        numhl           = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl          = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff       = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir    = {
            interval = 1000,
            follow_files = true
        },
        update_debounce = 150,
        max_file_length = 10000,
    })
end

return {
    package = package,
    config = config,
}
