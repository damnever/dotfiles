local package = { -- For 'wbthomason/packer.nvim'
  'vim-airline/vim-airline', disable = true,
}

local config = function()
  require('lib').vimbatch.global_vars({
    ['airline#extensions#tabline#enabled'] = 1,
    ['airline#extensions#tabline#show_buffers'] = 0,
    ['airline#extensions#tabline#show_splits'] = 0,
    ['airline#extensions#tabline#show_tab_nr'] = 1,
    ['airline#extensions#tabline#tab_nr_type'] = 1,
    airline_left_sep = '▶',
    airline_left_alt_sep = '❯',
    airline_right_sep = '◀',
    airline_right_alt_sep = '❮',
    ['airline_symbols.linenr'] = '¶',
    ['airline_symbols.branch'] = '⎇',
    -- https://github.com/bling/vim-airline/wiki/Screenshots: laederon, tomorrow, bubblegum, wombat ..
    airline_theme = 'dark',
  })
end

return {
  package = package,
  config = config,
}
