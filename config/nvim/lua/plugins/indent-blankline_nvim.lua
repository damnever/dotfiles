local package = { -- For 'wbthomason/packer.nvim'
    'lukas-reineke/indent-blankline.nvim',
    event = "BufReadPost",
}


local config = function()
    vim.opt.list = true
    vim.opt.listchars:remove('eol') -- Disable end of line char.

    require("ibl").setup({
        scope = {
            enabled = false,
            show_start = false,
            show_end = false,
        },
    })
end


return {
    package = package,
    config = config,
}
