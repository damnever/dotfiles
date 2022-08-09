local package = { -- For 'wbthomason/packer.nvim'
    'williamboman/mason.nvim',
    after = { 'cmp-nvim-lsp', 'lsp-format.nvim' },
    requires = {
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'jose-elias-alvarez/null-ls.nvim', requires = { { 'nvim-lua/plenary.nvim' }, { 'folke/trouble.nvim' }, } },
        { 'lukas-reineke/lsp-format.nvim' },
    },
}

local config = function()
    local lsp_servers = {
        -- Bash
        bashls = {
            flags = { debounce_text_changes = 150, },
        },
        -- C/C++
        clangd = {
            flags = { debounce_text_changes = 150, },
        },
        -- Deno
        -- "denols",
        -- Golang
        gopls = {
            flags = {
                debounce_text_changes = 150,
            },
            single_file_support = true,
            cmd = { "gopls", "serve" },
            filetypes = { "go", "gomod" },
            root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    ["local"] = "", -- TODO: parse current mod.
                    usePlaceholders = false,
                    analyses = {
                        shadow = true,
                        unusedparams = true,
                        unusedwrite = true,
                    },
                    hoverKind = "FullDocumentation",
                },
            },
        },
        -- Grammarly
        grammarly = {
            flags = { debounce_text_changes = 150, },
        },
        -- HTML
        html = {
            flags = { debounce_text_changes = 150, },
        },
        -- Java
        -- "jdtls",
        -- JSON
        jsonls = {
            flags = { debounce_text_changes = 150, },
        },
        -- Javascript
        tsserver = {
            flags = { debounce_text_changes = 150, },
        },
        -- Lua
        sumneko_lua = {
            flags = { debounce_text_changes = 150, },
        },
        -- Python
        pyright = {
            flags = { debounce_text_changes = 150, },
        },
        -- Rust
        rust_analyzer = {
            flags = { debounce_text_changes = 150, },
        },
        -- TOML
        taplo = {
            flags = { debounce_text_changes = 150, },
        },
        -- YAML
        yamlls = {
            flags = { debounce_text_changes = 150, },
        },

    }

    local function setup_mason()
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
            -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
            -- This setting has no relation with the `automatic_installation` setting.
            ensure_installed = lsp_server_names,
            -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
            -- This setting has no relation with the `ensure_installed` setting.
            -- Can either be:
            --   - false: Servers are not automatically installed.
            --   - true: All servers set up via lspconfig are automatically installed.
            --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
            automatic_installation = false,
        })
    end

    local function lspconfig_on_attach(client, bufnr)
        -- Format on save
        require("lsp-format").on_attach(client, bufnr)

        -- 'neovim/nvim-lspconfig'
        -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>jd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<leader>jD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', '<leader>jt', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>ji', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<leader>jr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>jk', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
        -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
        vim.api.nvim_create_autocmd("CursorHold", {
            buffer = bufnr,
            callback = function()
                local opts = {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                    border = 'rounded',
                    source = 'always',
                    prefix = ' ',
                    scope = 'cursor',
                }
                vim.diagnostic.open_float(nil, opts)
            end
        })
    end

    local function goto_definition(split_cmd)
        local util = vim.lsp.util
        local log = require("vim.lsp.log")
        local api = vim.api

        -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
        local handler = function(_, result, ctx)
            if result == nil or vim.tbl_isempty(result) then
                local _ = log.info() and log.info(ctx.method, "No location found")
                return nil
            end

            if split_cmd then
                vim.cmd(split_cmd)
            end

            if vim.tbl_islist(result) then
                util.jump_to_location(result[1])

                if #result > 1 then
                    util.set_qflist(util.locations_to_items(result))
                    api.nvim_command("copen")
                    api.nvim_command("wincmd p")
                end
            else
                util.jump_to_location(result)
            end
        end

        return handler
    end

    vim.lsp.handlers["textDocument/definition"] = goto_definition('split')
    vim.diagnostic.config({
        underline = { severity = vim.diagnostic.severity.INFO, },
        virtual_text = false,
        -- float = {},
        signs = {},
        update_in_insert = false,
        severity_sort = false,
    })

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

    setup_mason()
    setup_lspconfig()
end


return {
    package = package,
    config = config,
}
