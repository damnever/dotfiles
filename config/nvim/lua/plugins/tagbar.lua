local package = { -- For 'wbthomason/packer.nvim'
  'romgrk/barbar.nvim',
}


local config = function()
  local vimbatch = require('lib').vimbatch
  vimbatch.keymaps({
    { mode = 'n', lhs = '<leader>b', rhs = ':TagbarToggle<CR>', opts = { remap = true } },
  })
  -- tagbar for go: go install github.com/jstemmer/gotags@latest
  vimbatch.global_vars({
    tagbar_autofocus = 1,
    tagbar_type_go = {
      ctagstype  = 'go',
      kinds      = {
        'p:package',
        'i:imports:1',
        'c:constants',
        'v:variables',
        't:types',
        'n:interfaces',
        'w:fields',
        'e:embedded',
        'm:methods',
        'r:constructor',
        'f:functions'
      },
      sro        = '.',
      kind2scope = {
        t = 'ctype',
        n = 'ntype'
      },
      scope2kind = {
        ctype = 't',
        ntype = 'n'
      },
      ctagsbin   = 'gotags',
      ctagsargs  = '-sort -silent'
    },
  })
end


return {
  package = package,
  config = config,
}
