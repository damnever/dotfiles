local config = function()
    local vim = vim

    local lsp_servers = {
        -- Bash
        bashls = {
            filetypes = { "sh", "bash" },
            flags = { debounce_text_changes = 150, },
        },
        -- C/C++
        clangd = {
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            flags = { debounce_text_changes = 150, },
        },
        -- CSS
        cssls = {
            filetypes = { "css", "scss", "less" },
            flags = { debounce_text_changes = 150, },
        },
        -- Deno
        -- "denols",
        -- Golang
        gopls = {
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            flags = {
                debounce_text_changes = 150,
            },
            single_file_support = true,
            cmd = { "gopls", "serve" },
            settings = {
                gopls = {
                    ["local"] = require('lib').parse_golang_module_name(),
                    usePlaceholders = false,
                    diagnosticsDelay = "300ms",
                    analyses = {
                        fieldalignment = false,
                        shadow = true,
                    },
                    codelenses = {
                        generate = true,
                    },
                    hoverKind = "FullDocumentation",
                },
            },
        },
        -- Grammarly
        -- grammarly = { filetypes = { "markdown", "txt", "rst" }, },
        -- HTML
        html = {
            filetypes = { "html" },
            flags = { debounce_text_changes = 150, },
            init_options = {
                provideFormatter = true,
            },
            settings = {
                html = {
                    format = { wrapLineLength = 0 }
                }
            }
        },
        -- Java
        -- "jdtls",
        -- JSON
        jsonls = {
            filetypes = { "json", "jsonc" },
            flags = { debounce_text_changes = 150, },
        },
        -- Javascript
        ts_ls = {
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
                "typescript.tsx" },
            flags = { debounce_text_changes = 150, },
        },
        -- Lua
        lua_ls = {
            filetypes = { "lua" },
            flags = { debounce_text_changes = 150, },
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "3",
                            space_around_table_field_list = "true",
                            space_before_inline_comment = "1",
                            align_continuous_assign_statement = "false",
                            align_array_table = "false",
                        },
                    },
                }
            },
        },
        -- Python
        pyright = {
            filetypes = { "python" },
            flags = { debounce_text_changes = 150, },
        },
        -- Rust
        rust_analyzer = {
            filetypes = { "rust" },
            flags = { debounce_text_changes = 150, },
        },
        -- Swift
        sourcekit = {
            -- clone sourcekit-lsp; switch release-of-xcode-swift-version; xcrun swift build --configuration=release
            -- cmd = { "/usr/local/bin/sourcekit-lsp" },
            no_install_required = true,
            filetypes = { "swift", "objective-c", "objective-cpp" },
        },
        -- TOML
        taplo = {
            filetypes = { "toml" },
            flags = { debounce_text_changes = 150, },
        },
        -- YAML
        yamlls = {
            filetypes = { "yaml" },
            flags = { debounce_text_changes = 150, },
            settings = {
                yaml = {
                    keyOrdering = false,
                    -- # yaml-language-server: $schema=<http or file>
                    schemas = {},
                }
            }
        },
        -- Terraform (hashicorp)
        terraformls = {
            filetypes = { "terraform" },
            flags = { debounce_text_changes = 150, },
        },
    }

    local function setup_mason()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = " ", -- ✓
                    package_pending = "󱥸 ", -- ◍
                    package_uninstalled = "" -- ✗
                }
            }
        })
        -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
        local lsp_server_names = {}
        for k, v in pairs(lsp_servers) do
            if not v.no_install_required then
                table.insert(lsp_server_names, k)
            end
        end
        require("mason-lspconfig").setup({
            ensure_installed = lsp_server_names,
            automatic_enable = true,
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
        local diagnostic_signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
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

    -- Ref: https://github.com/golang/tools/blob/master/gopls/doc/vim.md
    local gopls_organize_imports_on_save_augroup = vim.api.nvim_create_augroup("LspGoplsOrganizeImportsOnSave", {})
    local function go_organize_imports_on_save()
        local function go_organize_imports(buf, wait_ms)
            local params = vim.lsp.util.make_range_params(0, vim.lsp.util._get_offset_encoding(buf))
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(buf, "textDocument/codeAction", params, wait_ms)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
        end

        vim.api.nvim_clear_autocmds({ group = gopls_organize_imports_on_save_augroup })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = gopls_organize_imports_on_save_augroup,
            pattern = { "*.go" },
            callback = function(env)
                go_organize_imports(env.buf, 3000)
            end,
        })
    end

    local lspformat_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local function format_on_save(client, bufnr)
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        if filetype == "swift" then
            -- Prefer SwiftFormat from null-ls/none-ls rather than swift-format from sourcekit-lsp, as they conflict with each other.
            return
        end
        if client:supports_method("textDocument/formatting", bufnr) then
            vim.api.nvim_clear_autocmds({ group = lspformat_augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = lspformat_augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = true, timeout_ms = 5000, bufnr = bufnr, })
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
        vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        vim.keymap.set('n', '<space>q', function()
            local ok, trouble = pcall(require, "trouble")
            if ok then
                return trouble.open({ mode = "diagnostics", focus = true, refresh = true, new = false, filter = { buf = 0 } })
            end

            local ok, telescope_builtin = pcall(require, "telescope.builtin")
            if ok then
                return telescope_builtin.diagnostics({ bufnr = 0 })
            else
                return vim.diagnostic.setloclist()
            end
        end, opts)
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>jD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', '<leader>jd', function()
            local ok, telescope_builtin = pcall(require, "telescope.builtin")
            if ok then
                return telescope_builtin.lsp_definitions({ jump_type = "split" })
            else
                return vim.lsp.buf.definition()
            end
        end, bufopts)
        vim.keymap.set('n', '<leader>jt', function()
            local ok, telescope_builtin = pcall(require, "telescope.builtin")
            if ok then
                return telescope_builtin.lsp_type_definitions({ jump_type = "split" })
            else
                return vim.lsp.buf.type_definition()
            end
        end, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>ji', function()
            local ok, telescope_builtin = pcall(require, "telescope.builtin")
            if ok then
                return telescope_builtin.lsp_implementations({ jump_type = "split" })
            else
                return vim.lsp.buf.implementation()
            end
        end, bufopts)
        vim.keymap.set('n', '<leader>jr', function()
            local ok, telescope_builtin = pcall(require, "telescope.builtin")
            if ok then
                return telescope_builtin.lsp_references({ jump_type = "split" })
            else
                return vim.lsp.buf.references()
            end
        end, bufopts)
        vim.keymap.set('n', '<leader>jk', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
        end, bufopts)
    end

    local function goto_definition(split_cmd)
        local log = require("vim.lsp.log")

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
            if vim.islist(result) then
                maybe_split_buffer(result[1].uri)
                vim.lsp.util.show_document(result[1], offset_encoding, { focus = true })

                if #result > 1 then
                    -- Use setqflist() instead?
                    vim.lsp.util.set_qflist(vim.lsp.util.locations_to_items(result, offset_encoding))
                    vim.api.nvim_command("copen")
                    vim.api.nvim_command("wincmd p")
                end
            else
                maybe_split_buffer(result.uri)
                vim.lsp.util.show_document(result, offset_encoding, { focus = true })
            end
        end
    end

    local function lsp_handlers()
        -- TODO: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
        --[[ local border = { ]]
        --[[ { "🭽", "FloatBorder" }, ]]
        --[[ { "▔", "FloatBorder" }, ]]
        --[[ { "🭾", "FloatBorder" }, ]]
        --[[ { "▕", "FloatBorder" }, ]]
        --[[ { "🭿", "FloatBorder" }, ]]
        --[[ { "▁", "FloatBorder" }, ]]
        --[[ { "🭼", "FloatBorder" }, ]]
        --[[ { "▏", "FloatBorder" }, ]]
        --[[ } ]]
        -- LSP settings (for overriding per client)
        return {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", }),
        }
    end

    local function setup_lspconfig()
        -- Ref: https://github.com/hrsh7th/cmp-nvim-lsp/issues/38
        -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local must_opts = {
            capabilities = capabilities,
            on_attach = lspconfig_on_attach,
            handlers = lsp_handlers(),
        }
        for name, opts in pairs(lsp_servers) do
            opts["no_install_required"] = nil -- remove it
            for k, v in pairs(must_opts) do
                opts[k] = v
            end
            vim.lsp.enable(name)
            vim.lsp.config(name, opts)
        end

        vim.lsp.handlers["textDocument/definition"] = goto_definition('split')
        setup_diagnostic()
    end

    setup_mason()
    setup_lspconfig()
    go_organize_imports_on_save()
end


return { {
    'williamboman/mason.nvim',
    dependencies = {
        { 'cmp-nvim-lsp' },
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason-lspconfig.nvim' },
    },
    config = config,
} }

