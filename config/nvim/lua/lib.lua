local vim = vim

local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

local function split_file_path(path)
    return string.match(path, "(.-)([^\\/]-%.?([^%.\\/]*))$")
end

local function data_cache_dir(name)
    return os.getenv("HOME") .. '/.cache/nvim/' .. name
end

local function ensure_data_cache_dir(name)
    local dir = data_cache_dir(name)
    if vim.fn.isdirectory(dir) == 0 then
        os.execute("mkdir -p " .. dir)
    end
    return dir
end

-- fn must be function(dir, file, isdir, dirctx) -> (number, subdirctx),
-- the return values: 0 stop, 1 ok, 2 skip directory, subdirctx is related to directory.
local function walk_directory(dir, fn, dirctx)
    for _, file in pairs(vim.fn.readdir(dir)) do
        local path = dir .. '/' .. file
        local isdir = vim.fn.isdirectory(path) ~= 0
        local state, subdirctx = fn(dir, file, isdir, dirctx)
        if state == 0 then
            return
        end
        if state == 1 and isdir then
            walk_directory(path, fn, subdirctx)
        end
    end
end

local function list_modules(module_prefix, root_dir, ignores_pattern)
    ignores_pattern = ignores_pattern or '^$'
    local modules = {}
    walk_directory(root_dir, function(dir, file, isdir, dirctx)
        if string.match(dir .. '/' .. file, ignores_pattern) then
            return 2, nil
        end
        if isdir then
            return 1, { module_prefix = dirctx.module_prefix .. '/' .. file }
        end
        if string.match(file, '.+%.lua$') then -- Only lua files.
            table.insert(modules, dirctx.module_prefix .. '/' .. string.gsub(file, "%.lua$", ""))
        end
        return 1, nil
    end, { module_prefix = module_prefix })
    return modules
end

local function parse_golang_module_name()
    local mod_file = vim.fn.expand('go.mod')
    if vim.fn.filereadable(mod_file) == 0 then
        return ''
    end
    for _, line in ipairs(vim.fn.readfile(mod_file)) do
        if string.match(line, '^module%s+.+') then
            return string.gsub(line, '^module%s+', '')
        end
    end
    return ''
end

------------------------------------
-- VIM API enhancements.
local vimbatch = {
    keymaps = function(keymaps)
        keymaps = keymaps or {}
        for _, keymap in ipairs(keymaps) do
            -- unpack?
            vim.keymap.set(keymap.mode, keymap.lhs, keymap.rhs, keymap.opts)
        end
    end,
    global_vars = function(vars)
        vars = vars or {}
        for k, v in pairs(vars) do
            vim.g[k] = v
        end
    end
}

return {
    dump_table = dump,

    split_file_path = split_file_path,
    data_cache_dir = data_cache_dir,
    ensure_data_cache_dir = ensure_data_cache_dir,

    list_modules = list_modules,

    parse_golang_module_name = parse_golang_module_name,

    vimbatch = vimbatch,
}
