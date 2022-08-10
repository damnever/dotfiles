local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    local packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

local packages = {}
local plugin_modules = require('lib').list_modules('plugins', vim.fn.stdpath('config') .. '/lua/plugins')
for _, name in ipairs(plugin_modules) do
    local mod = require(name)
    local package = mod.package
    package.config = mod.config
    table.insert(packages, package)
end

-- FIXME: Automatically run :PackerCompile whenever plugins/ directory is updated.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    for _, package in ipairs(packages) do
        -- print('====', require('lib').dump_table(package))
        use(package)
    end
end)
