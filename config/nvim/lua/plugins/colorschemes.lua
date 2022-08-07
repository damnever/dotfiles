local package = { -- For 'wbthomason/packer.nvim'
  'tomasr/molokai',
  requires = {
    { "catppuccin/nvim", as = "catppuccin" },
    { 'folke/tokyonight.nvim' },
    { 'Mofiqul/vscode.nvim' },
  }
}

local config = function()
  require('lib').vimbatch.global_vars({
    -- molokai_original = 1,
    -- rehash256 = 1,
  })

  vim.o.background = 'dark'
  vim.o.t_Co = 256
  vim.o.t_ut = nil
  vim.cmd([[colorscheme tokyonight]])
end

return {
  package = package,
  config = config,
}
