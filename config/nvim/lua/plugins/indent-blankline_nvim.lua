local package = { -- For 'wbthomason/packer.nvim'
  'lukas-reineke/indent-blankline.nvim',
}

local config = function()
  vim.opt.list = true
  vim.opt.listchars:append "eol:↴"

  require("indent_blankline").setup {
    show_end_of_line = true,
    -- space_char_blankline = " ",
  }
end

return {
  package = package,
  config = config,
}
