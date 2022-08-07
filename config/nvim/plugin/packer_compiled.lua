-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/damnever/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/damnever/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/damnever/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/damnever/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/damnever/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Dockerfile.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim",
    url = "https://github.com/ekalinin/Dockerfile.vim"
  },
  ["barbar.nvim"] = {
    config = { "\27LJ\2\nÌ\3\0\0\6\0\17\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0009\1\3\0004\3\3\0005\4\4\0005\5\5\0=\5\6\4>\4\1\3B\1\2\0019\1\a\0005\3\b\0005\4\t\0005\5\n\0=\5\v\0045\5\f\0=\5\r\0045\5\14\0=\5\15\4=\4\16\3B\1\2\1K\0\1\0\19tagbar_type_go\15scope2kind\1\0\2\nntype\6n\nctype\6t\15kind2scope\1\0\2\6t\nctype\6n\nntype\nkinds\1\f\0\0\14p:package\16i:imports:1\16c:constants\16v:variables\ft:types\17n:interfaces\rw:fields\15e:embedded\14m:methods\18r:constructor\16f:functions\1\0\4\bsro\6.\14ctagsargs\18-sort -silent\rctagsbin\vgotags\14ctagstype\ago\1\0\1\21tagbar_autofocus\3\1\16global_vars\topts\1\0\1\nremap\2\1\0\3\blhs\14<leader>b\tmode\6n\brhs\22:TagbarToggle<CR>\fkeymaps\rvimbatch\blib\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nã\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\4\fnumbers\fordinal\tmode\ttabs\16diagnostics\1\20max_name_length\3\23\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-dictionary"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/cmp-dictionary",
    url = "https://github.com/uga-rosa/cmp-dictionary"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    after_files = { "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  ["cmp-vsnip"] = {
    after_files = { "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-vsnip/after/plugin/cmp_vsnip.vim" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nñ\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\1\22current_line_only\2\17AFTER_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequireó\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\1\22current_line_only\2\18BEFORE_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequire®\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\2\22current_line_only\2\16hint_offset\3ˇˇˇˇ\15\17AFTER_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequire©\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\2\22current_line_only\2\16hint_offset\3ˇˇˇˇ\15\18BEFORE_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15hint_lines\bhop\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15hint_words\bhop\frequireÊ\2\1\0\5\0\20\0&6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0009\0\6\0004\2\a\0005\3\a\0003\4\b\0=\4\t\3>\3\1\0025\3\n\0003\4\v\0=\4\t\3>\3\2\0025\3\f\0003\4\r\0=\4\t\3>\3\3\0025\3\14\0003\4\15\0=\4\t\3>\3\4\0025\3\16\0003\4\17\0=\4\t\3>\3\5\0025\3\18\0003\4\19\0=\4\t\3>\3\6\2B\0\2\1K\0\1\0\0\1\0\2\blhs\22<leader><leader>w\tmode\5\0\1\0\2\blhs\22<leader><leader>g\tmode\5\0\1\0\2\blhs\6T\tmode\5\0\1\0\2\blhs\6t\tmode\5\0\1\0\2\blhs\6F\tmode\5\brhs\0\1\0\2\blhs\6f\tmode\5\fkeymaps\rvimbatch\blib\1\0\1\tkeys\24qweruiopasdfghjklcn\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n©\1\0\0\4\0\n\0\0186\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0009\0\3\0\18\2\0\0009\0\4\0'\3\5\0B\0\3\0016\0\6\0'\2\a\0B\0\2\0029\0\b\0005\2\t\0B\0\2\1K\0\1\0\1\0\1\21show_end_of_line\2\nsetup\21indent_blankline\frequire\feol:‚Ü¥\vappend\14listchars\tlist\bopt\bvim\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine-lsp-progress"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/lualine-lsp-progress",
    url = "https://github.com/arkav/lualine-lsp-progress"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n™\6\0\0\6\0&\0;6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0004\5\0\0=\5\t\0044\5\0\0=\5\n\4=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\28\0=\4\29\3=\3\30\0025\3\31\0004\4\0\0=\4\19\0034\4\0\0=\4\21\0035\4 \0=\4\23\0035\4!\0=\4\25\0034\4\0\0=\4\27\0034\4\0\0=\4\29\3=\3\"\0024\3\0\0=\3#\0024\3\0\0=\3\n\0024\3\0\0=\3$\0024\3\0\0=\3%\2B\0\2\1K\0\1\0\15extensions\20inactive_winbar\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\3\0\0\rfilename\17lsp_progress\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\frefresh\1\0\3\ftabline\3Ë\a\vwinbar\3Ë\a\15statusline\3Ë\a\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\25always_divide_middle\2\ntheme\19powerline_dark\18icons_enabled\2\17globalstatus\1\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\nŒ\4\0\0\t\1\28\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0014\0\0\0006\1\b\0-\3\0\0B\1\2\4H\4\5Ä6\5\t\0009\5\n\5\18\a\0\0\18\b\4\0B\5\3\1F\4\3\2R\4˘6\1\0\0'\3\v\0B\1\2\0029\1\2\0015\3\f\0=\0\r\3B\1\2\0015\1\14\0006\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\19\0006\6\15\0009\6\20\0069\6\21\6\18\a\1\0B\2\5\0016\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\22\0006\6\15\0009\6\20\0069\6\23\6\18\a\1\0B\2\5\0016\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\24\0006\6\15\0009\6\20\0069\6\25\6\18\a\1\0B\2\5\0016\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\26\0006\6\15\0009\6\20\0069\6\27\6\18\a\1\0B\2\5\1K\0\1\0\0¿\15setloclist\r<space>q\14goto_next\a]d\14goto_prev\a[d\15open_float\15diagnostic\r<space>e\6n\bset\vkeymap\bvim\1\0\2\fnoremap\2\vsilent\2\21ensure_installed\1\0\1\27automatic_installation\1\20mason-lspconfig\vinsert\ntable\npairs\aui\1\0\0\nicons\1\0\0\1\0\3\24package_uninstalled\b‚úó\20package_pending\b‚óç\22package_installed\b‚úì\nsetup\nmason\frequired\0\0\6\0\6\0\v6\0\0\0006\2\1\0009\2\2\0026\4\1\0009\4\3\0049\4\4\0049\4\5\4B\4\1\0A\2\0\0A\0\0\1K\0\1\0\27list_workspace_folders\bbuf\blsp\finspect\bvim\nprint©\a\1\2\t\0$\0ã\0016\2\0\0009\2\1\0029\2\2\2\18\4\1\0'\5\3\0'\6\4\0B\2\4\0015\2\5\0=\1\6\0026\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\n\0006\a\0\0009\a\v\a9\a\f\a9\a\r\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\14\0006\a\0\0009\a\v\a9\a\f\a9\a\15\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\16\0006\a\0\0009\a\v\a9\a\f\a9\a\17\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\18\0006\a\0\0009\a\v\a9\a\f\a9\a\19\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\20\0006\a\0\0009\a\v\a9\a\f\a9\a\21\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\22\0006\a\0\0009\a\v\a9\a\f\a9\a\23\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\24\0006\a\0\0009\a\v\a9\a\f\a9\a\25\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\26\0003\a\27\0\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\28\0006\a\0\0009\a\v\a9\a\f\a9\a\29\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\30\0006\a\0\0009\a\v\a9\a\f\a9\a\31\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6 \0006\a\0\0009\a\v\a9\a\f\a9\a!\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\"\0006\a\0\0009\a\v\a9\a\f\a9\a#\a\18\b\2\0B\3\5\1K\0\1\0\15formatting\r<space>f\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\0\14<space>wl\28remove_workspace_folder\14<space>wr\25add_workspace_folder\14<space>wa\19signature_help\15<leader>jk\15references\15<leader>jr\19implementation\15<leader>ji\nhover\6K\16declaration\bbuf\blsp\15<leader>jd\6n\bset\vkeymap\vbuffer\1\0\2\fnoremap\2\vsilent\2\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvimö\2\0\0\15\2\r\0#6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2B\2\1\0A\0\0\0026\1\0\0'\3\a\0B\1\2\0025\2\b\0=\0\t\2-\3\0\0=\3\n\0026\3\v\0-\5\1\0B\3\2\4H\6\vÄ6\b\v\0\18\n\2\0B\b\2\4H\v\1Ä<\f\v\aF\v\3\3R\v˝8\b\6\0019\b\f\b\18\n\a\0B\b\2\1F\6\3\3R\6ÛK\0\1\0\2¿\0¿\nsetup\npairs\14on_attach\17capabilities\1\0\0\14lspconfig\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\frequireü\4\1\0\6\0\30\0,5\0\3\0005\1\1\0005\2\0\0=\2\2\1=\1\4\0005\1\6\0005\2\5\0=\2\2\1=\1\a\0005\1\t\0005\2\b\0=\2\2\0014\2\0\0=\2\n\1=\1\v\0005\1\r\0005\2\f\0=\2\2\1=\1\14\0005\1\16\0005\2\15\0=\2\2\1=\1\17\0005\1\19\0005\2\18\0=\2\2\1=\1\20\0005\1\22\0005\2\21\0=\2\2\1=\1\23\0005\1\25\0005\2\24\0=\2\2\1=\1\26\0003\1\27\0003\2\28\0003\3\29\0\18\4\1\0B\4\1\1\18\4\3\0B\4\1\0012\0\0ÄK\0\1\0\0\0\0\18rust_analyzer\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\fpyright\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\16sumneko_lua\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\rtsserver\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\vjsonls\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\ngopls\rsettings\1\0\1\24single_file_support\2\1\0\1\26debounce_text_changes\3ñ\1\vclangd\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\vbashls\1\0\0\nflags\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  molokai = {
    config = { "\27LJ\2\n√\1\0\0\3\0\f\0\0246\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0004\2\0\0B\0\2\0016\0\4\0009\0\5\0'\1\a\0=\1\6\0006\0\4\0009\0\5\0)\1\0\1=\1\b\0006\0\4\0009\0\5\0+\1\0\0=\1\t\0006\0\4\0009\0\n\0'\2\v\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\tt_ut\tt_Co\tdark\15background\6o\bvim\16global_vars\rvimbatch\blib\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/molokai",
    url = "https://github.com/tomasr/molokai"
  },
  nerdcommenter = {
    config = { "\27LJ\2\n]\0\0\3\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0005\2\4\0B\0\2\1K\0\1\0\1\0\1\20NERDSpaceDelims\3\1\16global_vars\rvimbatch\blib\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n»\2\0\0\6\0\16\0%6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\14\0004\4\b\0009\5\3\0009\5\4\0059\5\5\5>\5\1\0049\5\3\0009\5\4\0059\5\6\5>\5\2\0049\5\3\0009\5\4\0059\5\a\5>\5\3\0049\5\3\0009\5\4\0059\5\b\5>\5\4\0049\5\3\0009\5\4\0059\5\t\5>\5\5\0049\5\3\0009\5\n\0059\5\v\5>\5\6\0049\5\3\0009\5\f\0059\5\r\5>\5\a\4=\4\15\3B\1\2\1K\0\1\0\fsources\1\0\1\23diagnostics_format\23[#{c}] #{m} (#{s})\rmisspell\16diagnostics\nspell\15completion\14sqlformat\tyapf\frustfmt\14goimports\15lua_format\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n’\3\0\0\b\0\f\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0026\1\0\0'\3\a\0B\1\2\0029\2\b\1\18\4\2\0009\2\t\2'\5\n\0009\6\v\0B\6\1\0A\2\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\21disable_filetype\1\0\14\rcheck_ts\1\15break_undo\2\16enable_abbr\1\28enable_bracket_in_quote\2\30enable_check_bracket_line\2\22enable_afterquote\1\21enable_moveright\2\fmap_c_w\1\22ignored_next_char\19[%w%%%'%[%\"%.]\27disable_in_visualblock\1\21disable_in_macro\1\fmap_c_h\1\vmap_bs\2\vmap_cr\2\1\2\0\0\20TelescopePrompt\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-cmdline", "cmp-path", "cmp-buffer", "nvim-autopairs", "cmp-vsnip" },
    config = { "\27LJ\2\n–\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20Ä6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2p\0\2\n\0\4\0\0156\2\0\0009\2\1\0029\2\2\0026\4\0\0009\4\1\0049\4\3\4\18\6\0\0+\a\2\0+\b\2\0+\t\2\0B\4\5\2\18\5\1\0+\6\2\0B\2\4\1K\0\1\0\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÂ\1\0\1\5\3\b\1 -\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\22Ä6\1\2\0009\1\3\0019\1\4\1)\3\1\0B\1\2\2\t\1\0\0X\1\5Ä-\1\1\0'\3\5\0'\4\6\0B\1\3\1X\1\nÄ-\1\2\0B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\a\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\1¿\0¿\rcomplete\5!<Plug>(vsnip-expand-or-jump)\20vsnip#available\afn\bvim\21select_next_item\fvisible\2®\1\0\0\4\2\a\1\21-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0B\0\1\1X\0\vÄ6\0\2\0009\0\3\0009\0\4\0)\2ˇˇB\0\2\2\t\0\0\0X\0\4Ä-\0\1\0'\2\5\0'\3\6\0B\0\3\1K\0\1\0\2¿\1¿\5\28<Plug>(vsnip-jump-prev)\19vsnip#jumpable\afn\bvim\21select_prev_item\fvisible\2£\v\1\0\r\0I\0≠\0013\0\0\0003\1\1\0006\2\2\0'\4\3\0B\2\2\0029\3\4\0025\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\0054\6\0\0=\6\n\0059\6\v\0029\6\f\0069\6\r\0065\b\15\0009\t\v\0029\t\14\t)\v¸ˇB\t\2\2=\t\16\b9\t\v\0029\t\14\t)\v\4\0B\t\2\2=\t\17\b9\t\v\0029\t\18\tB\t\1\2=\t\19\b9\t\v\0029\t\20\tB\t\1\2=\t\21\b9\t\v\0029\t\22\t5\v\23\0B\t\2\2=\t\24\b9\t\v\0023\v\25\0005\f\26\0B\t\3\2=\t\27\b9\t\v\0023\v\28\0005\f\29\0B\t\3\2=\t\30\bB\6\2\2=\6\v\0059\6\31\0029\6 \0064\b\a\0005\t!\0>\t\1\b5\t\"\0>\t\2\b5\t#\0>\t\3\b5\t$\0>\t\4\b5\t%\0>\t\5\b5\t&\0>\t\6\b4\t\3\0005\n'\0>\n\1\t5\n(\0>\n\2\tB\6\3\2=\6 \0055\0063\0004\a\t\0009\b\31\0029\b)\b9\b*\b>\b\1\a9\b\31\0029\b)\b9\b+\b>\b\2\a9\b\31\0029\b)\b9\b,\b>\b\3\a6\b\2\0'\n-\0B\b\2\0029\b.\b>\b\4\a9\b\31\0029\b)\b9\b/\b>\b\5\a9\b\31\0029\b)\b9\b0\b>\b\6\a9\b\31\0029\b)\b9\b1\b>\b\a\a9\b\31\0029\b)\b9\b2\b>\b\b\a=\a4\6=\0065\5B\3\2\0019\3\4\0029\0036\3'\0057\0005\6:\0009\a\31\0029\a \a4\t\3\0005\n8\0>\n\1\t4\n\3\0005\v9\0>\v\1\nB\a\3\2=\a \6B\3\3\0019\3\4\0029\3;\3'\5<\0005\6=\0009\a\v\0029\a\f\a9\a;\aB\a\1\2=\a\v\0064\a\3\0005\b>\0>\b\1\a=\a \6B\3\3\0019\3\4\0029\3;\3'\5?\0005\6@\0009\a\v\0029\a\f\a9\a;\aB\a\1\2=\a\v\0069\a\31\0029\a \a4\t\3\0005\nA\0>\n\1\t4\n\3\0005\vB\0>\v\1\nB\a\3\2=\a \6B\3\3\0016\3\2\0'\5C\0B\3\2\0029\3\4\0035\5G\0005\6E\0005\aD\0=\aF\6=\6H\5B\3\2\0012\0\0ÄK\0\1\0\bdic\1\0\a\nasync\1\nexact\3\2\21document_command\16wn %s -over\rdocument\1\27first_case_insensitive\1\rcapacity\3\5\ndebug\1\6*\1\0\0\1\2\0\0\26/usr/share/dict/words\19cmp_dictionary\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\fsorting\16comparators\1\0\0\norder\vlength\14sort_text\tkind\nunder\25cmp-under-comparator\nscore\nexact\voffset\fcompare\1\0\2\19keyword_length\3\2\tname\15dictionary\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\nspell\1\0\1\tname\tpath\1\0\1\tname\29nvim_lsp_document_symbol\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\rnvim_lsp\fsources\vconfig\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0\0\0" },
    loaded = true,
    only_config = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\nı\1\0\0\5\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\3B\1\2\0016\1\6\0=\0\1\1K\0\1\0\bvim\nicons\1\0\5\nDEBUG\bÔÜà\tINFO\bÔ†µ\tWARN\bÔî©\nERROR\bÔôô\nTRACE\b‚úé\1\0\a\ftimeout\3–\15\vrender\fdefault\nlevel\tINFO\vstages\22fade_in_slide_out\18minimum_width\0032\bfps\3\30\22background_colour\vNormal\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n∂\16\0\0\b\0D\0z6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0004\5-\0005\6\a\0005\a\6\0=\a\b\6>\6\1\0055\6\t\0>\6\2\0055\6\n\0>\6\3\0055\6\f\0005\a\v\0=\a\b\6>\6\4\0055\6\r\0>\6\5\0055\6\14\0>\6\6\0055\6\15\0>\6\a\0055\6\16\0>\6\b\0055\6\17\0>\6\t\0055\6\18\0>\6\n\0055\6\19\0>\6\v\0055\6\20\0>\6\f\0055\6\21\0>\6\r\0055\6\22\0>\6\14\0055\6\23\0>\6\15\0055\6\24\0>\6\16\0055\6\25\0>\6\17\0055\6\26\0>\6\18\0055\6\27\0>\6\19\0055\6\28\0>\6\20\0055\6\29\0>\6\21\0055\6\30\0>\6\22\0055\6\31\0>\6\23\0055\6 \0>\6\24\0055\6!\0>\6\25\0055\6\"\0>\6\26\0055\6#\0>\6\27\0055\6$\0>\6\28\0055\6%\0>\6\29\0055\6&\0>\6\30\0055\6'\0>\6\31\0055\6(\0>\6 \0055\6)\0>\6!\0055\6*\0>\6\"\0055\6+\0>\6#\0055\6,\0>\6$\0055\6-\0>\6%\0055\6.\0>\6&\0055\6/\0>\6'\0055\0060\0>\6(\0055\0061\0>\6)\0055\0062\0>\6*\0055\0063\0>\6+\0055\0064\0>\6,\5=\0055\4=\0046\3=\0037\0025\0038\0=\0039\0025\3:\0005\4;\0=\4<\3=\3=\2B\0\2\0016\0\0\0'\2>\0B\0\2\0029\0?\0009\1@\0004\3\3\0005\4A\0005\5B\0=\5C\4>\4\1\3B\1\2\1K\0\1\0\topts\1\0\1\nremap\2\1\0\3\blhs\14<leader>n\tmode\6n\brhs\24:NvimTreeToggle<CR>\fkeymaps\rvimbatch\blib\ffilters\vcustom\1\14\0\0\v\\.pyc$\v\\.pyo$\v\\.egg$\16__pycache__\f\\.beam$\v\\.obj$\t\\.o$\v\\.out$\n\\.so$\f\\.test$\f^\\.git$\f^\\.svn$\v^\\.hg$\1\0\1\rdotfiles\1\rrenderer\1\0\1\16group_empty\2\tview\rmappings\tlist\1\0\2\vaction\14bulk_move\bkey\bbmv\1\0\2\vaction\16toggle_mark\bkey\6m\1\0\2\vaction\16toggle_help\bkey\ag?\1\0\2\vaction\21toggle_file_info\bkey\n<C-k>\1\0\2\vaction\21run_file_command\bkey\6.\1\0\2\vaction\16search_node\bkey\6S\1\0\2\vaction\15expand_all\bkey\6E\1\0\2\vaction\17collapse_all\bkey\6W\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\22clear_live_filter\bkey\6F\1\0\2\vaction\16live_filter\bkey\6f\1\0\2\vaction\16system_open\bkey\n<C-s>\1\0\2\vaction\vdir_up\bkey\6-\1\0\2\vaction\18next_git_item\bkey\a]c\1\0\2\vaction\19next_diag_item\bkey\a]e\1\0\2\vaction\18prev_git_item\bkey\a[c\1\0\2\vaction\19prev_diag_item\bkey\a[e\1\0\2\vaction\23copy_absolute_path\bkey\agy\1\0\2\vaction\14copy_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\6p\1\0\2\vaction\tcopy\bkey\6c\1\0\2\vaction\bcut\bkey\6x\1\0\2\vaction\16full_rename\bkey\n<C-r>\1\0\2\vaction\ntrash\bkey\6D\1\0\2\vaction\vremove\bkey\6d\1\0\2\vaction\vcreate\bkey\6a\1\0\2\vaction\frefresh\bkey\6r\1\0\2\vaction\18toggle_custom\bkey\6U\1\0\2\vaction\23toggle_git_ignored\bkey\6I\1\0\2\vaction\17last_sibling\bkey\6J\1\0\2\vaction\18first_sibling\bkey\6K\1\0\2\vaction\fpreview\bkey\n<Tab>\1\0\2\vaction\15close_node\bkey\t<BS>\1\0\2\vaction\16parent_node\bkey\6P\1\0\2\vaction\17next_sibling\bkey\6>\1\0\2\vaction\17prev_sibling\bkey\6<\1\0\2\vaction\vtabnew\bkey\n<C-t>\1\0\2\vaction\nsplit\bkey\6s\1\0\2\vaction\vvsplit\bkey\6v\1\0\1\vaction\acd\1\3\0\0\n<C-]>\19<2-RightMouse>\1\0\2\vaction\19edit_no_picker\bkey\6O\1\0\2\vaction\18edit_in_place\bkey\n<C-e>\bkey\1\0\1\vaction\tedit\1\4\0\0\t<CR>\6o\18<2-LeftMouse>\1\0\1\16custom_only\2\1\0\1\18adaptive_size\1\1\0\1\fsort_by\19case_sensitive\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nˆ\2\0\0\5\0\f\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0004\4\0\0=\4\b\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\frainbow\1\0\3\19max_file_lines\3Ë\a\venable\2\18extended_mode\2\14highlight\fdisable\1\0\2\venable\2&additional_vim_regex_highlighting\1\19ignore_install\21ensure_installed\1\0\2\17sync_install\1\17auto_install\2\1\16\0\0\6c\ncmake\tbash\ago\15javascript\tjson\njson5\blua\nproto\vpython\trust\bsql\ttoml\bvim\tyaml\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\1\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\16:normal! zx\bcmd\bvimq\1\1\6\0\a\0\r6\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\1\0009\1\3\0015\4\5\0003\5\4\0=\5\6\4B\1\3\1+\1\2\0002\0\0ÄL\1\2\0\tpost\1\0\0\0\fenhance\vselect\26telescope.actions.set\frequireD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15find_files\22telescope.builtin\frequireE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\16grep_string\22telescope.builtin\frequireC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14live_grep\22telescope.builtin\frequireA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fkeymaps\22telescope.builtin\frequireÎ\a\1\0\a\0/\0I5\0\0\0003\1\1\0=\1\2\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\16\0005\4\6\0005\5\a\0=\5\b\0045\5\t\0=\5\n\0044\5\0\0=\5\v\0045\5\f\0005\6\r\0=\6\14\5=\5\15\4=\4\17\0035\4\18\0=\0\19\4=\0\20\4=\0\21\4=\0\22\4=\0\23\4=\0\24\4=\4\25\0035\4\27\0005\5\26\0=\5\28\0045\5\29\0005\6\30\0=\6\31\5=\5 \4=\4!\3B\1\2\0016\1\3\0'\3\4\0B\1\2\0029\1\"\1'\3\28\0B\1\2\0016\1\3\0'\3\4\0B\1\2\0029\1\"\1'\3 \0B\1\2\0016\1\3\0'\3#\0B\1\2\0029\1$\0019\1%\0014\3\5\0005\4&\0003\5'\0=\5(\4>\4\1\0035\4)\0003\5*\0=\5(\4>\4\2\0035\4+\0003\5,\0=\5(\4>\4\3\0035\4-\0003\5.\0=\5(\4>\4\4\3B\1\2\1K\0\1\0\0\1\0\2\blhs\14<leader>k\tmode\5\0\1\0\2\blhs\14<leader>G\tmode\5\0\1\0\2\blhs\14<leader>g\tmode\6v\brhs\0\1\0\2\blhs\14<leader>p\tmode\5\fkeymaps\rvimbatch\blib\19load_extension\15extensions\rfrecency\20ignore_patterns\1\3\0\0\f*.git/*\f*/tmp/*\1\0\2\19show_unindexed\2\16show_scores\2\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\nfuzzy\1\14case_mode\15smart_case\25override_file_sorter\2\fpickers\roldfiles\14live_grep\16grep_string\14git_files\15find_files\fbuffers\1\0\0\rdefaults\1\0\0\18layout_config\15horizontal\1\0\1\18preview_width\4\0ÄÄÄˇ\3\1\0\1\20prompt_position\vbottom\25file_ignore_patterns\17path_display\1\2\0\0\rabsolute\16borderchars\1\t\0\0\6 \6 \6 \6 \6 \6 \6 \6 \1\0\5\20layout_strategy\15horizontal\20scroll_strategy\nlimit\17entry_prefix\6 \20selection_caret\6 \18prompt_prefix\n Ôëä \nsetup\14telescope\frequire\20attach_mappings\0\1\0\1\vhidden\2\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["thrift.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/thrift.vim",
    url = "https://github.com/solarnz/thrift.vim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = { "\27LJ\2\nŒ\5\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\nsigns\1\0\5\thint\bÔ†µ\fwarning\bÔî©\nerror\bÔôô\nother\bÔ´†\16information\bÔëâ\14auto_jump\1\2\0\0\20lsp_definitions\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\vcancel\n<esc>\tnext\6j\19toggle_preview\6P\16toggle_mode\6m\frefresh\6r\nhover\6K\nclose\6q\fpreview\6p\rprevious\6k\1\0\15\16fold_closed\bÔë†\ngroup\2\14auto_open\1\rposition\vbottom\25use_diagnostic_signs\1\vheight\3\n\nicons\2\tmode\26workspace_diagnostics\fpadding\2\14auto_fold\1\17auto_preview\2\15auto_close\1\14fold_open\bÔëº\17indent_lines\2\nwidth\0032\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "\27LJ\2\ni\0\0\3\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0005\2\4\0B\0\2\1K\0\1\0\1\0\1 undotree_SetFocusWhenToggle\3\1\16global_vars\rvimbatch\blib\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-jsonc"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-jsonc",
    url = "https://github.com/kevinoid/vim-jsonc"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-nginx"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-nginx",
    url = "https://github.com/fatih/vim-nginx"
  },
  ["vim-quickrun"] = {
    config = { "\27LJ\2\nà\2\0\0\6\0\r\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0009\1\3\0004\3\3\0005\4\4\0005\5\5\0=\5\6\4>\4\1\3B\1\2\0019\1\a\0005\3\v\0005\4\t\0005\5\b\0=\5\n\4=\4\f\3B\1\2\1K\0\1\0\20quickrun_config\1\0\1%quickrun_no_default_key_mappings\3\1\6_\1\0\0\1\0\1\14outputter\fmessage\16global_vars\topts\1\0\1\nremap\2\1\0\3\blhs\14<leader>r\tmode\6n\brhs\21<Plug>(quickrun)\fkeymaps\rvimbatch\blib\frequire\0" },
    keys = { { "n", "<leader>r" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-quickrun",
    url = "https://github.com/thinca/vim-quickrun"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/vim-tmux",
    url = "https://github.com/tmux-plugins/vim-tmux"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vscode.nvim"] = {
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/vscode.nvim",
    url = "https://github.com/Mofiqul/vscode.nvim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\nı\5\0\0\5\0%\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\0025\3\17\0005\4\18\0=\4\19\0035\4\20\0=\4\21\3=\3\22\0025\3\24\0005\4\23\0=\4\25\0035\4\26\0=\4\27\3=\3\28\0025\3\29\0=\3\30\0025\3 \0005\4\31\0=\4!\0035\4\"\0=\4#\3=\3$\2B\0\2\1K\0\1\0\23triggers_blacklist\6v\1\3\0\0\6j\6k\6i\1\0\0\1\3\0\0\6j\6k\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmax\0032\bmin\3\20\vheight\1\0\2\nalign\tleft\fspacing\3\3\1\0\2\bmax\3\25\bmin\3\4\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\3\rwinblend\3\0\rposition\vbottom\vborder\tnone\19popup_mappings\1\0\2\14scroll_up\n<c-u>\16scroll_down\n<c-d>\nicons\1\0\3\14separator\b‚ûú\ngroup\6+\15breadcrumb\a¬ª\15key_labels\14operators\1\0\1\agc\rComments\fplugins\1\0\3\rtriggers\tauto\14show_help\2\19ignore_missing\1\fpresets\1\0\a\fwindows\2\17text_objects\2\fmotions\2\14operators\2\6z\2\6g\2\bnav\2\rspelling\1\0\2\fenabled\1\16suggestions\3\20\1\0\2\14registers\2\nmarks\2\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/Users/damnever/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n©\1\0\0\4\0\n\0\0186\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0009\0\3\0\18\2\0\0009\0\4\0'\3\5\0B\0\3\0016\0\6\0'\2\a\0B\0\2\0029\0\b\0005\2\t\0B\0\2\1K\0\1\0\1\0\1\21show_end_of_line\2\nsetup\21indent_blankline\frequire\feol:‚Ü¥\vappend\14listchars\tlist\bopt\bvim\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: barbar.nvim
time([[Config for barbar.nvim]], true)
try_loadstring("\27LJ\2\nÌ\3\0\0\6\0\17\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0009\1\3\0004\3\3\0005\4\4\0005\5\5\0=\5\6\4>\4\1\3B\1\2\0019\1\a\0005\3\b\0005\4\t\0005\5\n\0=\5\v\0045\5\f\0=\5\r\0045\5\14\0=\5\15\4=\4\16\3B\1\2\1K\0\1\0\19tagbar_type_go\15scope2kind\1\0\2\nntype\6n\nctype\6t\15kind2scope\1\0\2\6t\nctype\6n\nntype\nkinds\1\f\0\0\14p:package\16i:imports:1\16c:constants\16v:variables\ft:types\17n:interfaces\rw:fields\15e:embedded\14m:methods\18r:constructor\16f:functions\1\0\4\bsro\6.\14ctagsargs\18-sort -silent\rctagsbin\vgotags\14ctagstype\ago\1\0\1\21tagbar_autofocus\3\1\16global_vars\topts\1\0\1\nremap\2\1\0\3\blhs\14<leader>b\tmode\6n\brhs\22:TagbarToggle<CR>\fkeymaps\rvimbatch\blib\frequire\0", "config", "barbar.nvim")
time([[Config for barbar.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\nı\1\0\0\5\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\3B\1\2\0016\1\6\0=\0\1\1K\0\1\0\bvim\nicons\1\0\5\nDEBUG\bÔÜà\tINFO\bÔ†µ\tWARN\bÔî©\nERROR\bÔôô\nTRACE\b‚úé\1\0\a\ftimeout\3–\15\vrender\fdefault\nlevel\tINFO\vstages\22fade_in_slide_out\18minimum_width\0032\bfps\3\30\22background_colour\vNormal\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: molokai
time([[Config for molokai]], true)
try_loadstring("\27LJ\2\n√\1\0\0\3\0\f\0\0246\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0004\2\0\0B\0\2\0016\0\4\0009\0\5\0'\1\a\0=\1\6\0006\0\4\0009\0\5\0)\1\0\1=\1\b\0006\0\4\0009\0\5\0+\1\0\0=\1\t\0006\0\4\0009\0\n\0'\2\v\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\tt_ut\tt_Co\tdark\15background\6o\bvim\16global_vars\rvimbatch\blib\frequire\0", "config", "molokai")
time([[Config for molokai]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n/\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\16:normal! zx\bcmd\bvimq\1\1\6\0\a\0\r6\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\1\0009\1\3\0015\4\5\0003\5\4\0=\5\6\4B\1\3\1+\1\2\0002\0\0ÄL\1\2\0\tpost\1\0\0\0\fenhance\vselect\26telescope.actions.set\frequireD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15find_files\22telescope.builtin\frequireE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\16grep_string\22telescope.builtin\frequireC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14live_grep\22telescope.builtin\frequireA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\fkeymaps\22telescope.builtin\frequireÎ\a\1\0\a\0/\0I5\0\0\0003\1\1\0=\1\2\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0015\3\16\0005\4\6\0005\5\a\0=\5\b\0045\5\t\0=\5\n\0044\5\0\0=\5\v\0045\5\f\0005\6\r\0=\6\14\5=\5\15\4=\4\17\0035\4\18\0=\0\19\4=\0\20\4=\0\21\4=\0\22\4=\0\23\4=\0\24\4=\4\25\0035\4\27\0005\5\26\0=\5\28\0045\5\29\0005\6\30\0=\6\31\5=\5 \4=\4!\3B\1\2\0016\1\3\0'\3\4\0B\1\2\0029\1\"\1'\3\28\0B\1\2\0016\1\3\0'\3\4\0B\1\2\0029\1\"\1'\3 \0B\1\2\0016\1\3\0'\3#\0B\1\2\0029\1$\0019\1%\0014\3\5\0005\4&\0003\5'\0=\5(\4>\4\1\0035\4)\0003\5*\0=\5(\4>\4\2\0035\4+\0003\5,\0=\5(\4>\4\3\0035\4-\0003\5.\0=\5(\4>\4\4\3B\1\2\1K\0\1\0\0\1\0\2\blhs\14<leader>k\tmode\5\0\1\0\2\blhs\14<leader>G\tmode\5\0\1\0\2\blhs\14<leader>g\tmode\6v\brhs\0\1\0\2\blhs\14<leader>p\tmode\5\fkeymaps\rvimbatch\blib\19load_extension\15extensions\rfrecency\20ignore_patterns\1\3\0\0\f*.git/*\f*/tmp/*\1\0\2\19show_unindexed\2\16show_scores\2\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\nfuzzy\1\14case_mode\15smart_case\25override_file_sorter\2\fpickers\roldfiles\14live_grep\16grep_string\14git_files\15find_files\fbuffers\1\0\0\rdefaults\1\0\0\18layout_config\15horizontal\1\0\1\18preview_width\4\0ÄÄÄˇ\3\1\0\1\20prompt_position\vbottom\25file_ignore_patterns\17path_display\1\2\0\0\rabsolute\16borderchars\1\t\0\0\6 \6 \6 \6 \6 \6 \6 \6 \1\0\5\20layout_strategy\15horizontal\20scroll_strategy\nlimit\17entry_prefix\6 \20selection_caret\6 \18prompt_prefix\n Ôëä \nsetup\14telescope\frequire\20attach_mappings\0\1\0\1\vhidden\2\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n™\6\0\0\6\0&\0;6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\15\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0004\5\0\0=\5\t\0044\5\0\0=\5\n\4=\4\v\0034\4\0\0=\4\f\0035\4\r\0=\4\14\3=\3\16\0025\3\18\0005\4\17\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\0035\4\24\0=\4\25\0035\4\26\0=\4\27\0035\4\28\0=\4\29\3=\3\30\0025\3\31\0004\4\0\0=\4\19\0034\4\0\0=\4\21\0035\4 \0=\4\23\0035\4!\0=\4\25\0034\4\0\0=\4\27\0034\4\0\0=\4\29\3=\3\"\0024\3\0\0=\3#\0024\3\0\0=\3\n\0024\3\0\0=\3$\0024\3\0\0=\3%\2B\0\2\1K\0\1\0\15extensions\20inactive_winbar\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\3\0\0\rfilename\17lsp_progress\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\frefresh\1\0\3\ftabline\3Ë\a\vwinbar\3Ë\a\15statusline\3Ë\a\17ignore_focus\23disabled_filetypes\vwinbar\15statusline\1\0\0\23section_separators\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\25component_separators\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\1\0\4\25always_divide_middle\2\ntheme\19powerline_dark\18icons_enabled\2\17globalstatus\1\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\nã\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\foptions\1\0\0\1\0\4\fnumbers\fordinal\tmode\ttabs\16diagnostics\1\20max_name_length\3\23\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nˆ\2\0\0\5\0\f\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0004\4\0\0=\4\b\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\frainbow\1\0\3\19max_file_lines\3Ë\a\venable\2\18extended_mode\2\14highlight\fdisable\1\0\2\venable\2&additional_vim_regex_highlighting\1\19ignore_install\21ensure_installed\1\0\2\17sync_install\1\17auto_install\2\1\16\0\0\6c\ncmake\tbash\ago\15javascript\tjson\njson5\blua\nproto\vpython\trust\bsql\ttoml\bvim\tyaml\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n–\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20Ä6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2p\0\2\n\0\4\0\0156\2\0\0009\2\1\0029\2\2\0026\4\0\0009\4\1\0049\4\3\4\18\6\0\0+\a\2\0+\b\2\0+\t\2\0B\4\5\2\18\5\1\0+\6\2\0B\2\4\1K\0\1\0\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvimÂ\1\0\1\5\3\b\1 -\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\1\1B\1\1\1X\1\22Ä6\1\2\0009\1\3\0019\1\4\1)\3\1\0B\1\2\2\t\1\0\0X\1\5Ä-\1\1\0'\3\5\0'\4\6\0B\1\3\1X\1\nÄ-\1\2\0B\1\1\2\15\0\1\0X\2\4Ä-\1\0\0009\1\a\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\2¿\1¿\0¿\rcomplete\5!<Plug>(vsnip-expand-or-jump)\20vsnip#available\afn\bvim\21select_next_item\fvisible\2®\1\0\0\4\2\a\1\21-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4Ä-\0\0\0009\0\1\0B\0\1\1X\0\vÄ6\0\2\0009\0\3\0009\0\4\0)\2ˇˇB\0\2\2\t\0\0\0X\0\4Ä-\0\1\0'\2\5\0'\3\6\0B\0\3\1K\0\1\0\2¿\1¿\5\28<Plug>(vsnip-jump-prev)\19vsnip#jumpable\afn\bvim\21select_prev_item\fvisible\2£\v\1\0\r\0I\0≠\0013\0\0\0003\1\1\0006\2\2\0'\4\3\0B\2\2\0029\3\4\0025\5\b\0005\6\6\0003\a\5\0=\a\a\6=\6\t\0054\6\0\0=\6\n\0059\6\v\0029\6\f\0069\6\r\0065\b\15\0009\t\v\0029\t\14\t)\v¸ˇB\t\2\2=\t\16\b9\t\v\0029\t\14\t)\v\4\0B\t\2\2=\t\17\b9\t\v\0029\t\18\tB\t\1\2=\t\19\b9\t\v\0029\t\20\tB\t\1\2=\t\21\b9\t\v\0029\t\22\t5\v\23\0B\t\2\2=\t\24\b9\t\v\0023\v\25\0005\f\26\0B\t\3\2=\t\27\b9\t\v\0023\v\28\0005\f\29\0B\t\3\2=\t\30\bB\6\2\2=\6\v\0059\6\31\0029\6 \0064\b\a\0005\t!\0>\t\1\b5\t\"\0>\t\2\b5\t#\0>\t\3\b5\t$\0>\t\4\b5\t%\0>\t\5\b5\t&\0>\t\6\b4\t\3\0005\n'\0>\n\1\t5\n(\0>\n\2\tB\6\3\2=\6 \0055\0063\0004\a\t\0009\b\31\0029\b)\b9\b*\b>\b\1\a9\b\31\0029\b)\b9\b+\b>\b\2\a9\b\31\0029\b)\b9\b,\b>\b\3\a6\b\2\0'\n-\0B\b\2\0029\b.\b>\b\4\a9\b\31\0029\b)\b9\b/\b>\b\5\a9\b\31\0029\b)\b9\b0\b>\b\6\a9\b\31\0029\b)\b9\b1\b>\b\a\a9\b\31\0029\b)\b9\b2\b>\b\b\a=\a4\6=\0065\5B\3\2\0019\3\4\0029\0036\3'\0057\0005\6:\0009\a\31\0029\a \a4\t\3\0005\n8\0>\n\1\t4\n\3\0005\v9\0>\v\1\nB\a\3\2=\a \6B\3\3\0019\3\4\0029\3;\3'\5<\0005\6=\0009\a\v\0029\a\f\a9\a;\aB\a\1\2=\a\v\0064\a\3\0005\b>\0>\b\1\a=\a \6B\3\3\0019\3\4\0029\3;\3'\5?\0005\6@\0009\a\v\0029\a\f\a9\a;\aB\a\1\2=\a\v\0069\a\31\0029\a \a4\t\3\0005\nA\0>\n\1\t4\n\3\0005\vB\0>\v\1\nB\a\3\2=\a \6B\3\3\0016\3\2\0'\5C\0B\3\2\0029\3\4\0035\5G\0005\6E\0005\aD\0=\aF\6=\6H\5B\3\2\0012\0\0ÄK\0\1\0\bdic\1\0\a\nasync\1\nexact\3\2\21document_command\16wn %s -over\rdocument\1\27first_case_insensitive\1\rcapacity\3\5\ndebug\1\6*\1\0\0\1\2\0\0\26/usr/share/dict/words\19cmp_dictionary\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\fcmp_git\14gitcommit\rfiletype\fsorting\16comparators\1\0\0\norder\vlength\14sort_text\tkind\nunder\25cmp-under-comparator\nscore\nexact\voffset\fcompare\1\0\2\19keyword_length\3\2\tname\15dictionary\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\nspell\1\0\1\tname\tpath\1\0\1\tname\29nvim_lsp_document_symbol\1\0\1\tname\28nvim_lsp_signature_help\1\0\1\tname\rnvim_lsp\fsources\vconfig\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0\0\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nñ\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\1\22current_line_only\2\17AFTER_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequireó\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\1\22current_line_only\2\18BEFORE_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequire®\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\2\22current_line_only\2\16hint_offset\3ˇˇˇˇ\15\17AFTER_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequire©\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0006\3\0\0'\5\3\0B\3\2\0029\3\4\0039\3\5\3=\3\a\2B\0\2\1K\0\1\0\14direction\1\0\2\22current_line_only\2\16hint_offset\3ˇˇˇˇ\15\18BEFORE_CURSOR\18HintDirection\rhop.hint\15hint_char1\bhop\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15hint_lines\bhop\frequire6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15hint_words\bhop\frequireÊ\2\1\0\5\0\20\0&6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0009\0\6\0004\2\a\0005\3\a\0003\4\b\0=\4\t\3>\3\1\0025\3\n\0003\4\v\0=\4\t\3>\3\2\0025\3\f\0003\4\r\0=\4\t\3>\3\3\0025\3\14\0003\4\15\0=\4\t\3>\3\4\0025\3\16\0003\4\17\0=\4\t\3>\3\5\0025\3\18\0003\4\19\0=\4\t\3>\3\6\2B\0\2\1K\0\1\0\0\1\0\2\blhs\22<leader><leader>w\tmode\5\0\1\0\2\blhs\22<leader><leader>g\tmode\5\0\1\0\2\blhs\6T\tmode\5\0\1\0\2\blhs\6t\tmode\5\0\1\0\2\blhs\6F\tmode\5\brhs\0\1\0\2\blhs\6f\tmode\5\fkeymaps\rvimbatch\blib\1\0\1\tkeys\24qweruiopasdfghjklcn\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\1\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n»\2\0\0\6\0\16\0%6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\14\0004\4\b\0009\5\3\0009\5\4\0059\5\5\5>\5\1\0049\5\3\0009\5\4\0059\5\6\5>\5\2\0049\5\3\0009\5\4\0059\5\a\5>\5\3\0049\5\3\0009\5\4\0059\5\b\5>\5\4\0049\5\3\0009\5\4\0059\5\t\5>\5\5\0049\5\3\0009\5\n\0059\5\v\5>\5\6\0049\5\3\0009\5\f\0059\5\r\5>\5\a\4=\4\15\3B\1\2\1K\0\1\0\fsources\1\0\1\23diagnostics_format\23[#{c}] #{m} (#{s})\rmisspell\16diagnostics\nspell\15completion\14sqlformat\tyapf\frustfmt\14goimports\15lua_format\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n∂\16\0\0\b\0D\0z6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0004\5-\0005\6\a\0005\a\6\0=\a\b\6>\6\1\0055\6\t\0>\6\2\0055\6\n\0>\6\3\0055\6\f\0005\a\v\0=\a\b\6>\6\4\0055\6\r\0>\6\5\0055\6\14\0>\6\6\0055\6\15\0>\6\a\0055\6\16\0>\6\b\0055\6\17\0>\6\t\0055\6\18\0>\6\n\0055\6\19\0>\6\v\0055\6\20\0>\6\f\0055\6\21\0>\6\r\0055\6\22\0>\6\14\0055\6\23\0>\6\15\0055\6\24\0>\6\16\0055\6\25\0>\6\17\0055\6\26\0>\6\18\0055\6\27\0>\6\19\0055\6\28\0>\6\20\0055\6\29\0>\6\21\0055\6\30\0>\6\22\0055\6\31\0>\6\23\0055\6 \0>\6\24\0055\6!\0>\6\25\0055\6\"\0>\6\26\0055\6#\0>\6\27\0055\6$\0>\6\28\0055\6%\0>\6\29\0055\6&\0>\6\30\0055\6'\0>\6\31\0055\6(\0>\6 \0055\6)\0>\6!\0055\6*\0>\6\"\0055\6+\0>\6#\0055\6,\0>\6$\0055\6-\0>\6%\0055\6.\0>\6&\0055\6/\0>\6'\0055\0060\0>\6(\0055\0061\0>\6)\0055\0062\0>\6*\0055\0063\0>\6+\0055\0064\0>\6,\5=\0055\4=\0046\3=\0037\0025\0038\0=\0039\0025\3:\0005\4;\0=\4<\3=\3=\2B\0\2\0016\0\0\0'\2>\0B\0\2\0029\0?\0009\1@\0004\3\3\0005\4A\0005\5B\0=\5C\4>\4\1\3B\1\2\1K\0\1\0\topts\1\0\1\nremap\2\1\0\3\blhs\14<leader>n\tmode\6n\brhs\24:NvimTreeToggle<CR>\fkeymaps\rvimbatch\blib\ffilters\vcustom\1\14\0\0\v\\.pyc$\v\\.pyo$\v\\.egg$\16__pycache__\f\\.beam$\v\\.obj$\t\\.o$\v\\.out$\n\\.so$\f\\.test$\f^\\.git$\f^\\.svn$\v^\\.hg$\1\0\1\rdotfiles\1\rrenderer\1\0\1\16group_empty\2\tview\rmappings\tlist\1\0\2\vaction\14bulk_move\bkey\bbmv\1\0\2\vaction\16toggle_mark\bkey\6m\1\0\2\vaction\16toggle_help\bkey\ag?\1\0\2\vaction\21toggle_file_info\bkey\n<C-k>\1\0\2\vaction\21run_file_command\bkey\6.\1\0\2\vaction\16search_node\bkey\6S\1\0\2\vaction\15expand_all\bkey\6E\1\0\2\vaction\17collapse_all\bkey\6W\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\22clear_live_filter\bkey\6F\1\0\2\vaction\16live_filter\bkey\6f\1\0\2\vaction\16system_open\bkey\n<C-s>\1\0\2\vaction\vdir_up\bkey\6-\1\0\2\vaction\18next_git_item\bkey\a]c\1\0\2\vaction\19next_diag_item\bkey\a]e\1\0\2\vaction\18prev_git_item\bkey\a[c\1\0\2\vaction\19prev_diag_item\bkey\a[e\1\0\2\vaction\23copy_absolute_path\bkey\agy\1\0\2\vaction\14copy_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\6p\1\0\2\vaction\tcopy\bkey\6c\1\0\2\vaction\bcut\bkey\6x\1\0\2\vaction\16full_rename\bkey\n<C-r>\1\0\2\vaction\ntrash\bkey\6D\1\0\2\vaction\vremove\bkey\6d\1\0\2\vaction\vcreate\bkey\6a\1\0\2\vaction\frefresh\bkey\6r\1\0\2\vaction\18toggle_custom\bkey\6U\1\0\2\vaction\23toggle_git_ignored\bkey\6I\1\0\2\vaction\17last_sibling\bkey\6J\1\0\2\vaction\18first_sibling\bkey\6K\1\0\2\vaction\fpreview\bkey\n<Tab>\1\0\2\vaction\15close_node\bkey\t<BS>\1\0\2\vaction\16parent_node\bkey\6P\1\0\2\vaction\17next_sibling\bkey\6>\1\0\2\vaction\17prev_sibling\bkey\6<\1\0\2\vaction\vtabnew\bkey\n<C-t>\1\0\2\vaction\nsplit\bkey\6s\1\0\2\vaction\vvsplit\bkey\6v\1\0\1\vaction\acd\1\3\0\0\n<C-]>\19<2-RightMouse>\1\0\2\vaction\19edit_no_picker\bkey\6O\1\0\2\vaction\18edit_in_place\bkey\n<C-e>\bkey\1\0\1\vaction\tedit\1\4\0\0\t<CR>\6o\18<2-LeftMouse>\1\0\1\16custom_only\2\1\0\1\18adaptive_size\1\1\0\1\fsort_by\19case_sensitive\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\nı\5\0\0\5\0%\0)6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\0025\3\17\0005\4\18\0=\4\19\0035\4\20\0=\4\21\3=\3\22\0025\3\24\0005\4\23\0=\4\25\0035\4\26\0=\4\27\3=\3\28\0025\3\29\0=\3\30\0025\3 \0005\4\31\0=\4!\0035\4\"\0=\4#\3=\3$\2B\0\2\1K\0\1\0\23triggers_blacklist\6v\1\3\0\0\6j\6k\6i\1\0\0\1\3\0\0\6j\6k\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\nwidth\1\0\2\bmax\0032\bmin\3\20\vheight\1\0\2\nalign\tleft\fspacing\3\3\1\0\2\bmax\3\25\bmin\3\4\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\3\rwinblend\3\0\rposition\vbottom\vborder\tnone\19popup_mappings\1\0\2\14scroll_up\n<c-u>\16scroll_down\n<c-d>\nicons\1\0\3\14separator\b‚ûú\ngroup\6+\15breadcrumb\a¬ª\15key_labels\14operators\1\0\1\agc\rComments\fplugins\1\0\3\rtriggers\tauto\14show_help\2\19ignore_missing\1\fpresets\1\0\a\fwindows\2\17text_objects\2\fmotions\2\14operators\2\6z\2\6g\2\bnav\2\rspelling\1\0\2\fenabled\1\16suggestions\3\20\1\0\2\14registers\2\nmarks\2\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: nerdcommenter
time([[Config for nerdcommenter]], true)
try_loadstring("\27LJ\2\n]\0\0\3\0\5\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0005\2\4\0B\0\2\1K\0\1\0\1\0\1\20NERDSpaceDelims\3\1\16global_vars\rvimbatch\blib\frequire\0", "config", "nerdcommenter")
time([[Config for nerdcommenter]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-autopairs ]]

-- Config for: nvim-autopairs
try_loadstring("\27LJ\2\n’\3\0\0\b\0\f\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\0\0'\2\6\0B\0\2\0026\1\0\0'\3\a\0B\1\2\0029\2\b\1\18\4\2\0009\2\t\2'\5\n\0009\6\v\0B\6\1\0A\2\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\21disable_filetype\1\0\14\rcheck_ts\1\15break_undo\2\16enable_abbr\1\28enable_bracket_in_quote\2\30enable_check_bracket_line\2\22enable_afterquote\1\21enable_moveright\2\fmap_c_w\1\22ignored_next_char\19[%w%%%'%[%\"%.]\27disable_in_visualblock\1\21disable_in_macro\1\fmap_c_h\1\vmap_bs\2\vmap_cr\2\1\2\0\0\20TelescopePrompt\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")

vim.cmd [[ packadd cmp-buffer ]]
vim.cmd [[ packadd cmp-cmdline ]]
vim.cmd [[ packadd cmp-vsnip ]]
vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd cmp-nvim-lsp ]]
vim.cmd [[ packadd mason.nvim ]]

-- Config for: mason.nvim
try_loadstring("\27LJ\2\nŒ\4\0\0\t\1\28\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0014\0\0\0006\1\b\0-\3\0\0B\1\2\4H\4\5Ä6\5\t\0009\5\n\5\18\a\0\0\18\b\4\0B\5\3\1F\4\3\2R\4˘6\1\0\0'\3\v\0B\1\2\0029\1\2\0015\3\f\0=\0\r\3B\1\2\0015\1\14\0006\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\19\0006\6\15\0009\6\20\0069\6\21\6\18\a\1\0B\2\5\0016\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\22\0006\6\15\0009\6\20\0069\6\23\6\18\a\1\0B\2\5\0016\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\24\0006\6\15\0009\6\20\0069\6\25\6\18\a\1\0B\2\5\0016\2\15\0009\2\16\0029\2\17\2'\4\18\0'\5\26\0006\6\15\0009\6\20\0069\6\27\6\18\a\1\0B\2\5\1K\0\1\0\0¿\15setloclist\r<space>q\14goto_next\a]d\14goto_prev\a[d\15open_float\15diagnostic\r<space>e\6n\bset\vkeymap\bvim\1\0\2\fnoremap\2\vsilent\2\21ensure_installed\1\0\1\27automatic_installation\1\20mason-lspconfig\vinsert\ntable\npairs\aui\1\0\0\nicons\1\0\0\1\0\3\24package_uninstalled\b‚úó\20package_pending\b‚óç\22package_installed\b‚úì\nsetup\nmason\frequired\0\0\6\0\6\0\v6\0\0\0006\2\1\0009\2\2\0026\4\1\0009\4\3\0049\4\4\0049\4\5\4B\4\1\0A\2\0\0A\0\0\1K\0\1\0\27list_workspace_folders\bbuf\blsp\finspect\bvim\nprint©\a\1\2\t\0$\0ã\0016\2\0\0009\2\1\0029\2\2\2\18\4\1\0'\5\3\0'\6\4\0B\2\4\0015\2\5\0=\1\6\0026\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\n\0006\a\0\0009\a\v\a9\a\f\a9\a\r\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\14\0006\a\0\0009\a\v\a9\a\f\a9\a\15\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\16\0006\a\0\0009\a\v\a9\a\f\a9\a\17\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\18\0006\a\0\0009\a\v\a9\a\f\a9\a\19\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\20\0006\a\0\0009\a\v\a9\a\f\a9\a\21\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\22\0006\a\0\0009\a\v\a9\a\f\a9\a\23\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\24\0006\a\0\0009\a\v\a9\a\f\a9\a\25\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\26\0003\a\27\0\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\28\0006\a\0\0009\a\v\a9\a\f\a9\a\29\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\30\0006\a\0\0009\a\v\a9\a\f\a9\a\31\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6 \0006\a\0\0009\a\v\a9\a\f\a9\a!\a\18\b\2\0B\3\5\0016\3\0\0009\3\a\0039\3\b\3'\5\t\0'\6\"\0006\a\0\0009\a\v\a9\a\f\a9\a#\a\18\b\2\0B\3\5\1K\0\1\0\15formatting\r<space>f\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\0\14<space>wl\28remove_workspace_folder\14<space>wr\25add_workspace_folder\14<space>wa\19signature_help\15<leader>jk\15references\15<leader>jr\19implementation\15<leader>ji\nhover\6K\16declaration\bbuf\blsp\15<leader>jd\6n\bset\vkeymap\vbuffer\1\0\2\fnoremap\2\vsilent\2\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvimö\2\0\0\15\2\r\0#6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2B\2\1\0A\0\0\0026\1\0\0'\3\a\0B\1\2\0025\2\b\0=\0\t\2-\3\0\0=\3\n\0026\3\v\0-\5\1\0B\3\2\4H\6\vÄ6\b\v\0\18\n\2\0B\b\2\4H\v\1Ä<\f\v\aF\v\3\3R\v˝8\b\6\0019\b\f\b\18\n\a\0B\b\2\1F\6\3\3R\6ÛK\0\1\0\2¿\0¿\nsetup\npairs\14on_attach\17capabilities\1\0\0\14lspconfig\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\frequireü\4\1\0\6\0\30\0,5\0\3\0005\1\1\0005\2\0\0=\2\2\1=\1\4\0005\1\6\0005\2\5\0=\2\2\1=\1\a\0005\1\t\0005\2\b\0=\2\2\0014\2\0\0=\2\n\1=\1\v\0005\1\r\0005\2\f\0=\2\2\1=\1\14\0005\1\16\0005\2\15\0=\2\2\1=\1\17\0005\1\19\0005\2\18\0=\2\2\1=\1\20\0005\1\22\0005\2\21\0=\2\2\1=\1\23\0005\1\25\0005\2\24\0=\2\2\1=\1\26\0003\1\27\0003\2\28\0003\3\29\0\18\4\1\0B\4\1\1\18\4\3\0B\4\1\0012\0\0ÄK\0\1\0\0\0\0\18rust_analyzer\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\fpyright\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\16sumneko_lua\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\rtsserver\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\vjsonls\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\ngopls\rsettings\1\0\1\24single_file_support\2\1\0\1\26debounce_text_changes\3ñ\1\vclangd\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\vbashls\1\0\0\nflags\1\0\0\1\0\1\26debounce_text_changes\3ñ\1\0", "config", "mason.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleRefresh lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleRefresh", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <leader>r <cmd>lua require("packer.load")({'vim-quickrun'}, { keys = "<lt>leader>r", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType json ++once lua require("packer.load")({'vim-jsonc'}, { ft = "json" }, _G.packer_plugins)]]
vim.cmd [[au FileType jsonc ++once lua require("packer.load")({'vim-jsonc'}, { ft = "jsonc" }, _G.packer_plugins)]]
vim.cmd [[au FileType Dockerfile ++once lua require("packer.load")({'Dockerfile.vim'}, { ft = "Dockerfile" }, _G.packer_plugins)]]
vim.cmd [[au FileType nginx ++once lua require("packer.load")({'vim-nginx'}, { ft = "nginx" }, _G.packer_plugins)]]
vim.cmd [[au FileType thrift ++once lua require("packer.load")({'thrift.vim'}, { ft = "thrift" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]], true)
vim.cmd [[source /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]]
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-jsonc/ftdetect/jsonc.vim]], false)
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-nginx/ftdetect/nginx.vim]], true)
vim.cmd [[source /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-nginx/ftdetect/nginx.vim]]
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/vim-nginx/ftdetect/nginx.vim]], false)
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]], true)
vim.cmd [[source /Users/damnever/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]]
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/docker-compose.vim]], false)
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]], true)
vim.cmd [[source /Users/damnever/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]]
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/Dockerfile.vim/ftdetect/Dockerfile.vim]], false)
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/thrift.vim/ftdetect/thrift.vim]], true)
vim.cmd [[source /Users/damnever/.local/share/nvim/site/pack/packer/opt/thrift.vim/ftdetect/thrift.vim]]
time([[Sourcing ftdetect script at: /Users/damnever/.local/share/nvim/site/pack/packer/opt/thrift.vim/ftdetect/thrift.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
