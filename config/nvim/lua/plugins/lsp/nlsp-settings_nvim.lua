local config = function()
    require("nlspsettings").setup({
        config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers_fallback = { '.git' },
        append_default_schemas = true,
        loader = 'json'
    })
end

return { {
    'tamago324/nlsp-settings.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = config,
} }
