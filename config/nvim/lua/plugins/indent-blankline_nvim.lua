local package = { -- For 'wbthomason/packer.nvim'
  'lukas-reineke/indent-blankline.nvim',
}

local config = function()
  vim.opt.list = true
  vim.opt.listchars:remove('eol')  -- Disable end of line char.

  require("indent_blankline").setup {
    show_end_of_line = false,
    -- space_char_blankline = " ",
  }
end

return {
  package = package,
  config = config,
}
