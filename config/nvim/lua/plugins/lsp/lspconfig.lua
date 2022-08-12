local package = { -- For 'wbthomason/packer.nvim'
    'williamboman/mason.nvim',
    after = { 'cmp-nvim-lsp' },
    requires = {
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason-lspconfig.nvim' },
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
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    ["local"] = require('lib').parse_go_module_name(),
                    usePlaceholders = false,
                    analyses = {
                        shadow = true,
                        unusedparams = true,
                        unusedwrite = true,
                    },
                    codelenses = {
                        generate = true,
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
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "3",
                        },
                    },
                }
            },
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

    local function setup_diagnostic()
        vim.diagnostic.config({
            underline = true,
            virtual_text = false,
            -- float = {},
            signs = true,
            update_in_insert = false,
            severity_sort = false,
        })
        local diagnostic_signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
        for type, icon in pairs(diagnostic_signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end

    local function diagnostic_on_attach()
        local function diagnostic_format(diagnostic)
            local severity = 'X'
            if diagnostic.severity == vim.diagnostic.severity.HINT then
                severity = 'HINT'
            elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                severity = 'INFO'
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                severity = 'WARN'
            elseif diagnostic.severity == vim.diagnostic.severity.ERROR then
                severity = 'ERROR'
            end
            return string.format('[%s] %s (%s)', severity, diagnostic.message, diagnostic.source)
        end

        -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
        return function(client, bufnr)
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = function()
                    vim.diagnostic.open_float(nil, {
                        focusable = false,
                        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                        border = 'rounded',
                        source = false,
                        prefix = ' ',
                        scope = 'cursor',
                        format = diagnostic_format,
                    })
                end
            })
        end
    end

    local lsp_gopls_organize_imports_on_save_augroup = vim.api.nvim_create_augroup("LspGoplsOrganizeImpotsOnSave", {})
    local function go_organize_imports_on_save(client, bufnr)
        local function go_organize_imports(wait_ms)
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
        end

        vim.api.nvim_clear_autocmds({ group = lsp_gopls_organize_imports_on_save_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_gopls_organize_imports_on_save_augroup,
            pattern = { "*.go" },
            buffer = bufnr,
            callback = function()
                go_organize_imports(3000)
            end,
        })
    end

    local lspformat_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local function format_on_save(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = lspformat_augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = lspformat_augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- vim.lsp.buf.format({ filter = function(client) return client.name == "LSP-SOURCE-NAME" end, bufnr = bufnr, })
                    vim.lsp.buf.formatting_sync(nil, 3000)
                end,
            })
        end
    end

    local function lspconfig_on_attach(client, bufnr)
        -- Format on save
        format_on_save(client, bufnr)
        diagnostic_on_attach()(client, bufnr)

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
    end

    local function goto_definition(split_cmd)
        local util = vim.lsp.util
        local log = require("vim.lsp.log")
        local api = vim.api

        local function maybe_split_buffer(uri)
            local filename = string.gsub(uri, "^file://", "") -- Trim prefix.
            local current_buffer_filename = vim.api.nvim_buf_get_name(0)
            if filename ~= current_buffer_filename and split_cmd then
                vim.cmd(split_cmd)
            end
        end

        -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
        return function(err, result, ctx) -- :h lsp-handler
            if result == nil or vim.tbl_isempty(result) then
                local _ = log.info and log.info(ctx.method, "No location found")
                return nil
            end

            local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
            if vim.tbl_islist(result) then
                maybe_split_buffer(result[1].uri)
                util.jump_to_location(result[1], offset_encoding)

                if #result > 1 then
                    -- Use setqflist() instead?
                    util.set_qflist(util.locations_to_items(result, offset_encoding))
                    api.nvim_command("copen")
                    api.nvim_command("wincmd p")
                end
            else
                maybe_split_buffer(result.uri)
                util.jump_to_location(result, offset_encoding)
            end
        end
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

        vim.lsp.handlers["textDocument/definition"] = goto_definition('split')
        setup_diagnostic()
    end

    setup_mason()
    setup_lspconfig()
    go_organize_imports_on_save()
end


return {
    package = package,
    config = config,
}
