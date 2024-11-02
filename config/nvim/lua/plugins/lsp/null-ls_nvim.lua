local config = function()
    local vim = vim
    local lspformat_augroup = vim.api.nvim_create_augroup("NULLLSFormatting", {})
    local function format_on_save(client, bufnr)
        if client.supports_method("textDocument/formatting") then
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

    local null_ls = require("null-ls")
    null_ls.setup({
        debug = true,
        debounce = 500,
        on_attach = format_on_save,
        update_in_insert = false,
        should_attach = function(bufnr)
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
            return filetype == "swift" or filetype == "python"
        end,
        sources = {
            -- Example: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
            -- null_ls.builtins.x.y.with({}),
            -- Shell
            -- null_ls.builtins.code_actions.shellcheck,
            -- Javascript
            -- null_ls.builtins.diagnostics.eslint,
            -- Lua
            -- null_ls.builtins.diagnostics.luacheck,
            -- null_ls.builtins.formatting.lua_format,
            -- null_ls.builtins.formatting.stylua,
            -- Golang
            -- null_ls.builtins.formatting.goimports,
            -- Rust
            -- null_ls.builtins.formatting.rustfmt,
            -- Python
            -- require('null-ls').builtins.diagnostics.pylint,
            -- null_ls.builtins.diagnostics.flake8,
            -- null_ls.builtins.formatting.autopep8,
            null_ls.builtins.formatting.yapf,
            -- Swift
            null_ls.builtins.formatting.swiftformat.with({
                extra_args = {
                    "--disable",
                    "redundantSelf,redundantStaticSelf,wrapMultilineConditionalAssignment,wrapMultilineStatementBraces,wrapSingleLineComments,wrapSwitchCases",
                    "--maxwidth", "180", "--nowrapoperators", "=",
                    "--wraparguments", "preserve", "--wrapconditions", "preserve",
                    "--stripunusedargs", "unnamed-only"
                },
            }),
            -- sql
            -- null_ls.builtins.formatting.sqlformat,
            -- Writing and Spell
            -- null_ls.builtins.diagnostics.alex,
            -- null_ls.builtins.diagnostics.cspell,
            -- null_ls.builtins.completion.spell, -- NOTE: DO NOT use it!!!
            -- null_ls.builtins.formatting.codespell,
        },
        diagnostics_format = '[#{c}] #{m} (#{s})',
    })
end

return { {
    'nvimtools/none-ls.nvim', -- a community-maintained version of jose-elias-alvarez/null-ls.nvim
    dependencies = { { 'nvim-lua/plenary.nvim' }, { 'folke/trouble.nvim' }, },
    config = config,
} }
