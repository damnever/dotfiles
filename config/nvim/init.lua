-- Load my options, keymaps, autocommands, etc.
require('setup').setup()

-- Load lazy.nvim.
require('lazy_pm')

require('lib').load_colorscheme({ "tokyonight", "carbonfox", "unokai" })