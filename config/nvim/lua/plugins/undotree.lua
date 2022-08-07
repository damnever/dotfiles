local package = { -- For 'wbthomason/packer.nvim'
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
}

local config = function()
  require('lib').vimbatch.global_vars({
    undotree_SetFocusWhenToggle = 1,
  })
end

return {
  package = package,
  config = config,
}
