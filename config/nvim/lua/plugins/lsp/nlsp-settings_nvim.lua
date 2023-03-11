local package = {
    'tamago324/nlsp-settings.nvim',
    requires = { 'neovim/nvim-lspconfig' },
}

local config = function()
    require("nlspsettings").setup({
        config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers_fallback = { '.git' },
        append_default_schemas = true,
        loader = 'json'
    })
end

return {
    package = package,
    config = config,
}
