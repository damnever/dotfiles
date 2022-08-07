local package = { -- For 'wbthomason/packer.nvim'
  'lewis6991/gitsigns.nvim',
}

local config = function()
  require('gitsigns').setup()
end

return {
  package = package,
  config = config,
}
