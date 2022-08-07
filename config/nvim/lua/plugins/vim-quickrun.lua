local package = { -- For 'wbthomason/packer.nvim'
  'thinca/vim-quickrun',
  keys = { { 'n', '<leader>r' } },
}

local config = function()
  local vimbatch = require('lib').vimbatch
  vimbatch.keymaps({
    { mode = 'n', lhs = '<leader>r', rhs = '<Plug>(quickrun)', opts = { remap = true } },
  })
  vimbatch.global_vars({
    quickrun_config = {
      ['_'] = {
        outputter = 'message',
      },
    },
    quickrun_no_default_key_mappings = 1,
  })
end


return {
  package = package,
  config = config,
}
