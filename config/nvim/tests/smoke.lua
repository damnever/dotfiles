-- Run from the repository root:
-- ./scripts/test

local startup_error = vim.v.errmsg
vim.v.errmsg = ""
vim.opt.shadafile = "NONE"

local failures = {}

local function fail(message)
	table.insert(failures, message)
end

local function log_level_number(level)
	if type(level) == "string" then
		return vim.log.levels[level:upper()]
	end
	return level
end

local original_notify = vim.notify
vim.notify = function(message, level, opts)
	local severity = log_level_number(level)
	if severity and severity >= vim.log.levels.ERROR then
		fail("error notification: " .. tostring(message))
	end
	return original_notify(message, level, opts)
end

local function write_file(path, lines)
	vim.fn.mkdir(vim.fs.dirname(path), "p")
	local result = vim.fn.writefile(lines, path)
	if result ~= 0 then
		error("failed to write " .. path)
	end
end

local function has_parser(bufnr, language)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr, language)
	return ok and parser ~= nil
end

local function has_client(bufnr, name)
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if client.name == name then
			return true
		end
	end
	return false
end

local function check_search_keymap_descriptions()
	local leader = vim.g.mapleader
	local mappings = {
		{ mode = "n", lhs = leader .. " ", name = "commands" },
		{ mode = "n", lhs = leader .. "p", name = "files" },
		{ mode = "n", lhs = leader .. "P", name = "recent files" },
		{ mode = "x", lhs = leader .. "g", name = "selected text" },
		{ mode = "n", lhs = leader .. "G", name = "project text" },
		{ mode = "n", lhs = leader .. "B", name = "buffer text" },
		{ mode = "n", lhs = leader .. "S", name = "buffer symbols" },
		{ mode = "n", lhs = leader .. "h", name = "command history" },
		{ mode = "n", lhs = leader .. "k", name = "keymaps" },
		{ mode = "n", lhs = leader .. "cp", name = "clipboard history" },
	}

	for _, expected in ipairs(mappings) do
		local mapping = vim.fn.maparg(expected.lhs, expected.mode, false, true)
		if vim.tbl_isempty(mapping) then
			fail("missing search keymap for " .. expected.name)
		else
			local description = mapping.desc or ""
			local searchable_description = description:lower()
			if not searchable_description:find("search", 1, true) and not searchable_description:find("find", 1, true) then
				fail("search keymap description lacks Search/Find for " .. expected.name .. ": " .. description)
			end
		end
	end
end

local function run()
	local temp_root = vim.fn.tempname()
	vim.fn.mkdir(vim.fs.joinpath(temp_root, ".git"), "p")

	local cases = {
		{
			name = "Go",
			path = "go/main.go",
			filetype = "go",
			parser = "go",
			treesitter_symbols = true,
			lsp = "gopls",
			files = {
				["go/go.mod"] = { "module example.com/nvim-smoke", "", "go 1.26.0" },
				["go/main.go"] = {
					"package main",
					"",
					'import "fmt"',
					"",
					"func main() {",
					'\tfmt.Println("hello")',
					"}",
				},
			},
		},
		{
			name = "Python",
			path = "python/main.py",
			filetype = "python",
			parser = "python",
			treesitter_symbols = true,
			lsp = "pyright",
			files = {
				["python/pyproject.toml"] = { "[project]", 'name = "nvim-smoke"', 'version = "0.0.0"' },
				["python/main.py"] = { "def greeting() -> str:", '    return "hello"' },
			},
		},
		{
			name = "Swift",
			path = "swift/Sources/Smoke/main.swift",
			filetype = "swift",
			parser = "swift",
			treesitter_symbols = true,
			lsp = "sourcekit",
			files = {
				["swift/Package.swift"] = {
					"// swift-tools-version: 6.0",
					"import PackageDescription",
					"",
					'let package = Package(name: "Smoke", targets: [.executableTarget(name: "Smoke")])',
				},
				["swift/Sources/Smoke/main.swift"] = { 'print("hello")' },
			},
		},
		{
			name = "Bash",
			path = "bash/smoke.sh",
			filetype = "sh",
			parser = "bash",
			treesitter_symbols = true,
			lsp = "bashls",
			files = {
				["bash/smoke.sh"] = { "#!/usr/bin/env bash", "set -euo pipefail", "", "printf '%s\\n' hello" },
			},
		},
		{
			name = "TypeScript",
			path = "typescript/src/main.ts",
			filetype = "typescript",
			parser = "typescript",
			treesitter_symbols = true,
			lsp = "ts_ls",
			files = {
				["typescript/package.json"] = { '{ "name": "nvim-smoke", "private": true, "type": "module" }' },
				["typescript/tsconfig.json"] = {
					'{ "compilerOptions": { "strict": true, "noEmit": true, "target": "ES2022" } }',
				},
				["typescript/src/main.ts"] = { 'const greeting: string = "hello"', "void greeting" },
			},
		},
		{
			name = "Markdown",
			path = "markdown/README.md",
			filetype = "markdown",
			parser = "markdown",
			files = {
				["markdown/README.md"] = { "# Smoke test", "", "Hello from Neovim." },
			},
		},
		{
			name = "Lua",
			path = "lua/init.lua",
			filetype = "lua",
			parser = "lua",
			treesitter_symbols = true,
			lsp = "lua_ls",
			files = {
				["lua/.luarc.json"] = {
					'{ "$schema": "https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json" }',
				},
				["lua/init.lua"] = { 'local greeting = "hello"', "print(greeting)" },
			},
		},
	}

	for _, case in ipairs(cases) do
		for relative_path, lines in pairs(case.files) do
			write_file(vim.fs.joinpath(temp_root, relative_path), lines)
		end
	end

	check_search_keymap_descriptions()

	local notify_ok, notify_error = pcall(vim.notify, "Neovim smoke notification", vim.log.levels.INFO, {
		title = "nvim-smoke",
		timeout = 50,
	})
	if not notify_ok then
		fail("notification rendering failed: " .. tostring(notify_error))
	end
	vim.wait(100)

	for _, case in ipairs(cases) do
		local failure_count = #failures
		vim.v.errmsg = ""
		local path = vim.fs.joinpath(temp_root, case.path)
		vim.api.nvim_set_current_dir(vim.fs.dirname(path))

		local opened, open_error = pcall(vim.cmd.edit, vim.fn.fnameescape(path))
		if not opened then
			fail(case.name .. " failed to open: " .. tostring(open_error))
			goto continue
		end

		local bufnr = vim.api.nvim_get_current_buf()
		if not vim.wait(2000, function()
			return vim.bo[bufnr].filetype == case.filetype
		end, 50) then
			fail(case.name .. " detected filetype " .. vim.bo[bufnr].filetype .. ", expected " .. case.filetype)
		end

		if not vim.wait(10000, function()
			return has_parser(bufnr, case.parser)
		end, 100) then
			fail(case.name .. " Tree-sitter parser did not attach")
		end

		if case.treesitter_symbols then
			local query_ok, query = pcall(vim.treesitter.query.get, case.parser, "locals")
			if not query_ok or not query then
				fail(case.name .. " Tree-sitter locals query is unavailable for symbol search")
			end
		end

		if case.lsp and not vim.wait(15000, function()
			return has_client(bufnr, case.lsp)
		end, 100) then
			fail(case.name .. " LSP client " .. case.lsp .. " did not attach")
		end

		local saved, save_error = pcall(vim.cmd.write)
		if not saved then
			fail(case.name .. " failed to save: " .. tostring(save_error))
		end
		vim.wait(200)

		if vim.v.errmsg ~= "" then
			fail(case.name .. " set v:errmsg: " .. vim.v.errmsg)
		end

		if #failures == failure_count then
			vim.api.nvim_out_write("PASS " .. case.name .. "\n")
		else
			vim.api.nvim_err_writeln("FAIL " .. case.name)
		end

		::continue::
	end

	if startup_error ~= "" then
		fail("startup set v:errmsg: " .. startup_error)
	end

	local notify_loaded, notify = pcall(require, "notify")
	if notify_loaded then
		for _, record in ipairs(notify.history({ include_hidden = true })) do
			local level = log_level_number(record.level)
			if level and level >= vim.log.levels.ERROR then
				fail("notification history contains an error: " .. vim.inspect(record.message))
			end
		end
		notify.dismiss({ silent = true, pending = true })
	end

	local messages = vim.api.nvim_exec2("messages", { output = true }).output
	if
		messages:match("Error detected")
		or messages:match("Lua callback:")
		or messages:match("^E%d+:")
		or messages:match("\nE%d+:")
	then
		fail("Neovim message history contains an error:\n" .. messages)
	end

	vim.fn.delete(temp_root, "rf")

	if #failures > 0 then
		for _, failure in ipairs(failures) do
			vim.api.nvim_err_writeln("FAIL " .. failure)
		end
		vim.cmd("cquit 1")
		return
	end

	vim.api.nvim_out_write("PASS notification rendering and 7 language workflows\n")
	vim.cmd("qa!")
end

local ok, error_message = xpcall(run, debug.traceback)
if not ok then
	vim.api.nvim_err_writeln("FAIL smoke test crashed:\n" .. error_message)
	vim.cmd("cquit 1")
end
