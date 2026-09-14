-- Run from the repository root:
-- ./scripts/test

vim.opt.shadafile = "NONE"

local failures = {}

local function fail(message)
	table.insert(failures, message)
end

local function check_frecency_search()
	local extension_ok, extension = pcall(function()
		return require("telescope").extensions.frecency
	end)
	if not extension_ok then
		fail("Telescope frecency extension failed to load: " .. tostring(extension))
	elseif type(extension.frecency) ~= "function" then
		fail("Telescope frecency extension does not export the frecency picker")
	end

	local mapping = vim.fn.maparg(vim.g.mapleader .. "P", "n", false, true)
	if vim.tbl_isempty(mapping) or type(mapping.callback) ~= "function" then
		fail("missing Telescope frecency search keymap")
	end
end

local function open_symbol_search(filetype, lines, expected_title)
	vim.cmd.enew()
	vim.bo.filetype = filetype
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

	local mapping = vim.fn.maparg(vim.g.mapleader .. "S", "n", false, true)
	if vim.tbl_isempty(mapping) or type(mapping.callback) ~= "function" then
		fail("missing Treesitter symbol search keymap")
		return
	end

	local opened, open_error = pcall(mapping.callback)
	if not opened then
		fail(filetype .. " symbol search failed: " .. tostring(open_error))
		return
	end

	local prompt_bufnr = vim.api.nvim_get_current_buf()
	if vim.bo[prompt_bufnr].filetype ~= "TelescopePrompt" then
		fail(filetype .. " symbol search did not open Telescope")
		return
	end

	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	if picker.prompt_title ~= expected_title then
		fail(filetype .. " symbol search opened " .. picker.prompt_title .. ", expected " .. expected_title)
	end
	require("telescope.actions").close(prompt_bufnr)
end

local function run()
	check_frecency_search()
	open_symbol_search("lua", {
		"local function greeting()",
		'\treturn "hello"',
		"end",
	}, "Treesitter Symbols")
	open_symbol_search("markdown", { "# Search fallback", "", "Hello from Markdown." }, "Current Buffer Fuzzy")

	if #failures > 0 then
		for _, failure in ipairs(failures) do
			vim.api.nvim_err_writeln("FAIL " .. failure)
		end
		vim.cmd("cquit 1")
		return
	end

	vim.api.nvim_out_write("PASS Telescope frecency, Treesitter symbol search, and Markdown text fallback\n")
	vim.cmd("qa!")
end

local ok, error_message = xpcall(run, debug.traceback)
if not ok then
	vim.api.nvim_err_writeln("FAIL search test crashed:\n" .. error_message)
	vim.cmd("cquit 1")
end
