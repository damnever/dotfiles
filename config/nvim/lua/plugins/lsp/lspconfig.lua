local package = { -- For 'wbthomason/packer.nvim'
  'williamboman/mason.nvim', after = 'cmp-nvim-lsp',
  requires = {
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'jose-elias-alvarez/null-ls.nvim', requires = { { 'nvim-lua/plenary.nvim' }, { 'folke/trouble.nvim' }, } },
  },
}

local config = function()
  local lsp_servers = {
    bashls = {
      flags = { debounce_text_changes = 150, },
    },
    clangd = {
      flags = { debounce_text_changes = 150, },
    },
    -- "denols",
    gopls = {
      flags = { debounce_text_changes = 150, },
      single_file_support = true,
      settings = {},
    },
    -- "jdtls",
    jsonls = {
      flags = { debounce_text_changes = 150, },
    },
    tsserver = {
      flags = { debounce_text_changes = 150, },
    },
    sumneko_lua = {
      flags = { debounce_text_changes = 150, },
    },
    pyright = {
      flags = { debounce_text_changes = 150, },
    },
    rust_analyzer = {
      flags = { debounce_text_changes = 150, },
    },
  }

  local function setup_mason_and_some_lspconfig()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "◍",
          package_uninstalled = "✗"
        }
      }
    })
    -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
    local lsp_server_names = {}
    for k in pairs(lsp_servers) do
      table.insert(lsp_server_names, k)
    end
    require("mason-lspconfig").setup({
      ensure_installed = lsp_server_names,
      automatic_installation = false,
    })

    -- 'neovim/nvim-lspconfig'
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  end

  local function lspconfig_on_attach(client, bufnr)
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>jd', vim.lsp.buf.declaration, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>ji', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>jr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>jk', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end

  local function setup_lspconfig()
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lspconfig = require('lspconfig')
    local must_opts = {
      capabilities = capabilities,
      on_attach = lspconfig_on_attach,
    }
    for name, opts in pairs(lsp_servers) do
      for k, v in pairs(must_opts) do
        opts[k] = v
      end
      lspconfig[name].setup(opts)
    end
  end

  setup_mason_and_some_lspconfig()
  setup_lspconfig()
end


return {
  package = package,
  config = config,
}
