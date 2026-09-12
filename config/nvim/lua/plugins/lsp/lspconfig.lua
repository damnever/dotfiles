local config = function()
	local lsp_servers = {
		-- Bash
		bashls = {
			filetypes = { "sh", "bash" },
			flags = { debounce_text_changes = 150 },
		},
		-- C/C++
		clangd = {
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			flags = { debounce_text_changes = 150 },
		},
		-- CSS
		cssls = {
			filetypes = { "css", "scss", "less" },
			flags = { debounce_text_changes = 150 },
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
					["local"] = require("lib").parse_golang_module_name(),
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
			flags = { debounce_text_changes = 150 },
			init_options = {
				provideFormatter = true,
			},
			settings = {
				html = {
					format = { wrapLineLength = 0 },
				},
			},
		},
		-- Java
		-- "jdtls",
		-- JSON
		jsonls = {
			filetypes = { "json", "jsonc" },
			flags = { debounce_text_changes = 150 },
		},
		-- Javascript
		ts_ls = {
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			flags = { debounce_text_changes = 150 },
		},
		-- Lua
		lua_ls = {
			filetypes = { "lua" },
			flags = { debounce_text_changes = 150 },
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						},
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
					codeLens = {
						enable = true,
					},
					hint = {
						enable = true,
						semicolon = "Disable",
					},
					format = {
						enable = false,
					},
				},
			},
		},
		-- Python
		pyright = {
			filetypes = { "python" },
			flags = { debounce_text_changes = 150 },
		},
		-- Rust
		rust_analyzer = {
			filetypes = { "rust" },
			flags = { debounce_text_changes = 150 },
		},
		-- Swift
		sourcekit = {
			-- clone sourcekit-lsp; switch release-of-xcode-swift-version; xcrun swift build --configuration=release
			-- cmd = { "/usr/local/bin/sourcekit-lsp" },
			contrib_no_install_required = true,
			filetypes = { "swift", "objective-c", "objective-cpp" },
		},
		-- TOML
		taplo = {
			filetypes = { "toml" },
			flags = { debounce_text_changes = 150 },
		},
		-- YAML
		yamlls = {
			filetypes = { "yaml" },
			flags = { debounce_text_changes = 150 },
			settings = {
				yaml = {
					keyOrdering = false,
					-- # yaml-language-server: $schema=<http or file>
					schemas = {},
				},
			},
		},
		-- Terraform (hashicorp)
		terraformls = {
			filetypes = { "terraform" },
			flags = { debounce_text_changes = 150 },
		},
	}

	local function setup_mason()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = " ", -- ✓
					package_pending = "󱥸 ", -- ◍
					package_uninstalled = "", -- ✗
				},
			},
		})
		-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
		local lsp_server_names = {}
		for k, v in pairs(lsp_servers) do
			if not v.contrib_no_install_required then
				table.insert(lsp_server_names, k)
			end
		end
		require("mason-lspconfig").setup({
			ensure_installed = lsp_server_names,
			automatic_enable = true,
		})
	end

	local function setup_codesettings()
		local codesettings = require("codesettings")
		codesettings.setup({
			---Look for these config files
			config_file_paths = {
				".vscode/settings.json",
				"codesettings.json",
				"lspsettings.json",
				".codesettings.json",
				".lspsettings.json",
				".nvim/codesettings.json",
				".nvim/lspsettings.json",
			},
			---Integrate with jsonls to provide LSP completion for LSP settings based on schemas
			jsonls_integration = true,
			default_merge_opts = {
				--- How to merge lists; 'replace' (default), 'append', or 'prepend'
				list_behavior = "prepend",
			},
		})

		vim.lsp.config("*", {
			before_init = function(_, config)
				codesettings.with_local_settings(config.name, config)
			end,
		})
	end

	local function setup_conform_format_on_save()
		require("conform").setup({
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				swift = { "swiftformat" },
				go = { "goimports", lsp_format = "first" }, -- TODO: replace goimports with gopls code action.
			},
			formatters = {
				swiftformat = {
					inherit = true,
					args = {
						"--disable",
						"redundantSelf,redundantStaticSelf,wrapMultilineConditionalAssignment,wrapMultilineStatementBraces,wrapSingleLineComments,wrapSwitchCases",
						"--maxwidth",
						"180",
						"--nowrapoperators",
						"=",
						"--wraparguments",
						"preserve",
						"--wrapconditions",
						"preserve",
						"--stripunusedargs",
						"unnamed-only",
					},
				},
				goimports = {
					inherit = true,
					append_args = { "-local", require("lib").parse_golang_module_name() },
				},
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 5000,
				async = false,
			},
		})
	end

	local function setup_diagnostic()
		local severity = vim.diagnostic.severity
		vim.diagnostic.config({
			underline = true,
			virtual_text = false,
			-- float = {},
			signs = {
				text = {
					[severity.ERROR] = " ",
					[severity.WARN] = " ",
					[severity.INFO] = " ",
					[severity.HINT] = " ",
				},
				numhl = {
					[severity.ERROR] = "DiagnosticSignError",
					[severity.WARN] = "DiagnosticSignWarn",
					[severity.INFO] = "DiagnosticSignInfo",
					[severity.HINT] = "DiagnosticSignHint",
				},
			},
			update_in_insert = false,
			severity_sort = false,
		})
	end

	local function diagnostic_on_attach()
		local function diagnostic_format(diagnostic)
			local severity = "X"
			if diagnostic.severity == vim.diagnostic.severity.HINT then
				severity = "HINT"
			elseif diagnostic.severity == vim.diagnostic.severity.INFO then
				severity = "INFO"
			elseif diagnostic.severity == vim.diagnostic.severity.WARN then
				severity = "WARN"
			elseif diagnostic.severity == vim.diagnostic.severity.ERROR then
				severity = "ERROR"
			end
			return string.format("[%s] %s (%s)", severity, diagnostic.message, diagnostic.source)
		end

		-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
		return function(bufnr)
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = false,
						prefix = " ",
						scope = "cursor",
						format = diagnostic_format,
					})
				end,
			})
		end
	end

	local function lsp_signature_on_attach(bufnr)
		if vim.api.nvim_buf_get_name(bufnr):match("^fugitive://") or vim.bo[bufnr].buftype ~= "" then
			return -- Skip for special buffers
		end

		require("lsp_signature").on_attach({
			doc_lines = 0,
			max_height = 14,
			max_width = 80,
			wrap = true,
			floating_window_above_cur_line = true,
			-- floating_window_off_x = 1,
			-- floating_window_off_y = -2,
			close_timeout = 2000,
			hint_enable = false,
			hi_parameter = "LspSignatureActiveParameter",
			handler_opts = {
				-- double, rounded, single, shadow, none, or a table of borders
				border = require("lib").border("CmpBorder"),
			},
			fix_pos = false,
			padding = "",
			timer_interval = 200,
			always_trigger = false,
		})
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
		return function(_, result, ctx) -- :h lsp-handler
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

	local function lspconfig_on_attach(client, bufnr)
		diagnostic_on_attach()(bufnr)

		-- LSP Signature
		lsp_signature_on_attach(bufnr)

		-- 'neovim/nvim-lspconfig'
		-- Mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		local opts = { noremap = true, silent = true, buffer = bufnr }
		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		require("lib").vimbatch.keymaps({
			{
				mode = "n",
				lhs = "<space>e",
				rhs = vim.diagnostic.open_float,
				opts = vim.tbl_extend("force", opts, { desc = "Show diagnostics at cursor" }),
			},
			{
				mode = "n",
				lhs = "[d",
				rhs = function()
					vim.diagnostic.jump({ count = -1, float = true })
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }),
			},
			{
				mode = "n",
				lhs = "]d",
				rhs = function()
					vim.diagnostic.jump({ count = 1, float = true })
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }),
			},
			{
				mode = "n",
				lhs = "<space>q",
				rhs = function()
					local ok, trouble = pcall(require, "trouble")
					if ok then
						return trouble.open({
							mode = "diagnostics",
							focus = true,
							refresh = true,
							new = false,
							filter = { buf = 0 },
						})
					end

					local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
					if telescope_ok then
						return telescope_builtin.diagnostics({ bufnr = 0 })
					end
					return vim.diagnostic.setloclist()
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Search current buffer diagnostics" }),
			},
			{
				mode = "n",
				lhs = "<leader>jD",
				rhs = vim.lsp.buf.declaration,
				opts = vim.tbl_extend("force", opts, { desc = "Find declaration with LSP" }),
			},
			{
				mode = "n",
				lhs = "<leader>jd",
				rhs = function()
					local ok, telescope_builtin = pcall(require, "telescope.builtin")
					if ok then
						return telescope_builtin.lsp_definitions({ jump_type = "split" })
					end
					return goto_definition("split")
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Find definition with LSP" }),
			},
			{
				mode = "n",
				lhs = "<leader>jt",
				rhs = function()
					local ok, telescope_builtin = pcall(require, "telescope.builtin")
					if ok then
						return telescope_builtin.lsp_type_definitions({ jump_type = "split" })
					end
					return vim.lsp.buf.type_definition()
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Find type definition with LSP" }),
			},
			{
				mode = "n",
				lhs = "K",
				rhs = function()
					vim.lsp.buf.hover({ border = "rounded" })
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Show hover documentation with LSP" }),
			},
			{
				mode = "n",
				lhs = "<leader>ji",
				rhs = function()
					local ok, telescope_builtin = pcall(require, "telescope.builtin")
					if ok then
						return telescope_builtin.lsp_implementations({ jump_type = "split" })
					end
					return vim.lsp.buf.implementation()
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Find implementation with LSP" }),
			},
			{
				mode = "n",
				lhs = "<leader>jr",
				rhs = function()
					local ok, telescope_builtin = pcall(require, "telescope.builtin")
					if ok then
						return telescope_builtin.lsp_references({ jump_type = "split" })
					end
					return vim.lsp.buf.references()
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Find references with LSP" }),
			},
			{
				mode = "n",
				lhs = "<leader>jk",
				rhs = function()
					vim.lsp.buf.signature_help({ border = "rounded" })
				end,
				opts = vim.tbl_extend("force", opts, { desc = "Show signature help with LSP" }),
			},
			{
				mode = "n",
				lhs = "<space>wa",
				rhs = vim.lsp.buf.add_workspace_folder,
				opts = vim.tbl_extend("force", opts, { desc = "Add LSP workspace folder" }),
			},
			{
				mode = "n",
				lhs = "<space>wr",
				rhs = vim.lsp.buf.remove_workspace_folder,
				opts = vim.tbl_extend("force", opts, { desc = "Remove LSP workspace folder" }),
			},
			{
				mode = "n",
				lhs = "<space>rn",
				rhs = vim.lsp.buf.rename,
				opts = vim.tbl_extend("force", opts, { desc = "Rename symbol with LSP" }),
			},
			{
				mode = "n",
				lhs = "<space>ca",
				rhs = vim.lsp.buf.code_action,
				opts = vim.tbl_extend("force", opts, { desc = "Show code actions with LSP" }),
			},
		})
	end

	local function setup_lspconfig()
		-- Ref: https://github.com/hrsh7th/cmp-nvim-lsp/issues/38
		-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local must_opts = {
			capabilities = capabilities,
			-- on_attach = lspconfig_on_attach,
		}

		for name, opts in pairs(lsp_servers) do
			opts["contrib_no_install_required"] = nil -- remove it
			for k, v in pairs(must_opts) do
				opts[k] = v
			end

			vim.lsp.enable(name)
			vim.lsp.config(name, opts)
		end

		-- on_attach might conflict with default on_attach in lsp_servers settings,
		-- so we use LspAttach autocommand to setup lspconfig_on_attach.
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				-- local bufnr = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				for bufnr, _ in pairs(client.attached_buffers) do
					lspconfig_on_attach(client, bufnr)
				end
			end,
		})
	end

	setup_mason()
	setup_codesettings()
	setup_lspconfig()
	setup_conform_format_on_save()
	setup_diagnostic()
end

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			{ "cmp-nvim-lsp" },
			{ "neovim/nvim-lspconfig" }, -- Provide default configs.
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"stevearc/conform.nvim", -- formating
			},
			{
				-- NOTE: disable 'hrsh7th/cmp-nvim-lsp-signature-help' in ./lsp_cmp.lua
				"ray-x/lsp_signature.nvim",
			},
			{
				"mrjones2014/codesettings.nvim", -- Merge local lsp configs.
				ft = { "json", "jsonc" },
			},
		},
		config = config,
	},
}
