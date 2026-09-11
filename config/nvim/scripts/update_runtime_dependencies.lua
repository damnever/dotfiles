local function run()
	local parsers_updated = require("nvim-treesitter.install").update(nil, { summary = true }):wait(600000)
	assert(parsers_updated, "Tree-sitter parser update failed")

	local registry = require("mason-registry")
	local registry_updated = false
	local registry_update_succeeded = false
	registry.update(function(succeeded)
		registry_update_succeeded = succeeded
		registry_updated = true
	end)
	assert(
		vim.wait(300000, function()
			return registry_updated
		end),
		"Mason registry update timed out"
	)
	assert(registry_update_succeeded, "Mason registry update failed")

	local packages = registry.get_installed_packages()
	for _, name in ipairs({ "black" }) do
		local package = registry.get_package(name)
		if not package:is_installed() then
			table.insert(packages, package)
		end
	end

	local pending = 0
	local failures = {}
	for _, package in ipairs(packages) do
		local installed_version = package:is_installed() and package:get_installed_version() or "not installed"
		local latest_version = package:get_latest_version()
		if installed_version ~= latest_version then
			pending = pending + 1
			local package_name = package.name
			vim.api.nvim_out_write(("Updating %s: %s -> %s\n"):format(package_name, installed_version, latest_version))
			package:install({}, function(succeeded, result)
				if not succeeded then
					table.insert(failures, package_name .. ": " .. vim.inspect(result))
				end
				pending = pending - 1
			end)
		end
	end

	assert(
		vim.wait(900000, function()
			return pending == 0
		end),
		"Mason package update timed out"
	)
	assert(#failures == 0, table.concat(failures, "\n"))

	vim.api.nvim_out_write("Tree-sitter parsers and Mason packages are current\n")
	vim.cmd("qa!")
end

local succeeded, error_message = xpcall(run, debug.traceback)
if not succeeded then
	vim.api.nvim_err_writeln("Dependency update failed:\n" .. error_message)
	vim.cmd("cquit 1")
end
