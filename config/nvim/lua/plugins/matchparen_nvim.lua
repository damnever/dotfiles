local config = function()
  require('matchparen').setup({
    enabled = true,
    hl_group = 'MatchParen',
    debounce_time = 60,
  })
end

return { {
  'monkoose/matchparen.nvim',
  config = config,
} }
