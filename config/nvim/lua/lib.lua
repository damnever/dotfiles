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

local function list_modules(module_prefix, dir, ignores_pattern)
    local ignores_pattern = ignores_pattern or '^$'
    local modules = {}
    for _, file in pairs(vim.fn.readdir(dir)) do
        local path = dir .. '/' .. file
        if string.match(path, ignores_pattern) then
            -- Ignore file.
        elseif vim.fn.isdirectory(path) ~= 0 then -- Recursively.
            local sub_modules = list_modules(module_prefix .. '/' .. file, path, ignore_dirs)
            for _, module in ipairs(sub_modules) do
                table.insert(modules, module)
            end
        elseif string.match(file, '.+%.lua$') then -- Only lua files.
            table.insert(modules, module_prefix .. '/' .. string.gsub(file, "%.lua$", ""))
        end
    end
    return modules
end

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

local function set_opt(name, value, op, scopes)
    scopes = scopes or { vim.o }
    for _, scope in ipairs(scopes) do
        -- https://neovim.io/doc/user/options.html
        if op == nil then
            scope[name] = value
        elseif op == '+' then -- :set+=
            if type(scope[name]) == 'string' then
                scope[name] = scope[name] .. value
            else
                if type(value) ~= 'table' then value = { value } end
                scope[name] = scope[name] + value
            end
        elseif op == '-' then -- :set-=
            scope[name] = scope[name] - value
        elseif op == '^' then -- :set^=
            if type(scope[name]) == 'string' then
                scope[name] = value .. scope[name]
            else
                if type(value) ~= 'table' then value = { value } end
                scope[name] = scope[name] ^ value
            end
        end
    end
end

return {
    dump_table = dump,

    split_file_path = split_file_path,
    data_cache_dir = data_cache_dir,
    ensure_data_cache_dir = ensure_data_cache_dir,

    list_modules = list_modules,

    vimbatch = vimbatch,

    set_opt = set_opt,
}
