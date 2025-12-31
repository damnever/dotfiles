local treesitter_config = function()
    require("nvim-treesitter").setup({
        install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "tree-sitter"),
    })

    local ensure_installed = {
        "bash",
        "c",
        "cmake",
        "commonlisp",
        "go",
        "gomod",
        "gotmpl",
        "helm",
        "gowork",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "json5",
        "lua",
        "make",
        "markdown",
        "proto",
        "python",
        "rust",
        "rst",
        "sql",
        "swift",
        "toml",
        "vim",
        "yaml",
        "zsh",
    }

    vim.filetype.add({
        extension = {
            gotmpl = "gotmpl",
        },
        pattern = {
            [".*/templates/.*%.tpl"] = "helm",
            [".*/templates/.*%.ya?ml"] = "helm",
            ["helmfile.*%.ya?ml"] = "helm",
        },
    })

    require("nvim-treesitter").install(ensure_installed)

    local installing = {}

    local function start_treesitter(bufnr, lang)
        local parser = pcall(vim.treesitter.get_parser, bufnr, lang)
        if not parser then
            return false
        end

        if installing[lang] then
            installing[lang] = nil
        end

        -- start treesitter
        local started = pcall(vim.treesitter.start, bufnr, lang)
        if not started then
            return false
        end

        -- indentation
        vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- folding
        vim.api.nvim_buf_call(bufnr, function()
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"
        end)
        return true
    end

    local supported_parsers = require("nvim-treesitter.parsers")
    local function maybe_install(lang)
        if not supported_parsers[lang] then
            return false
        end

        if vim.tbl_contains(ensure_installed, lang) or installing[lang] then
            return false
        end

        require("nvim-treesitter.install").install({ lang })
        installing[lang] = true
        return true
    end

    local function maybe_install_and_start_treesitter(bufnr, lang, attempts)
        attempts = attempts or 20 -- ~20s worst case with 1s backoff

        if attempts <= 0 or not vim.api.nvim_buf_is_valid(bufnr) then
            return
        end

        if not maybe_install(lang) then
            if start_treesitter(bufnr, lang) then
                return
            end
        end

        vim.defer_fn(function()
            maybe_install_and_start_treesitter(bufnr, lang, attempts - 1)
        end, 1000)
    end

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(event)
            -- local file = event.file
            local bufnr = event.buf
            local lang = vim.treesitter.language.get_lang(event.match) or event.match

            -- local max_filesize = 32 * 1024 * 1024 -- 32 MiB
            -- local ok, stats = pcall(vim.loop.fs_stat, file)
            -- if ok and stats and stats.size > max_filesize then
            -- 	return
            -- end

            local started = start_treesitter(bufnr, lang)
            if not started then
                maybe_install_and_start_treesitter(bufnr, lang)
            end
        end,
    })
end

local treesitter_textobjects_config = function()
    -- configuration
    require("nvim-treesitter-textobjects").setup({
        select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V",  -- linewise
                -- ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
        },
        move = {
            -- whether to set jumps in the jumplist
            set_jumps = true,
        },
    })

    -- select
    vim.keymap.set({ "x", "o" }, "am", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "im", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "as", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
    end)

    -- move
    vim.keymap.set({ "n", "x", "o" }, "]m", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]]", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]s", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "][", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]S", function()
        require("nvim-treesitter-textobjects.move").goto_previous_end("@local.scope", "locals")
    end)
end

local treesitter_context_config = function()
    require("treesitter-context").setup({
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false,      -- Enable multiwindow support.
        max_lines = 2,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 35,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 10, -- Maximum number of lines to show for a single context
        trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    })

    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { bg = "NONE", fg = "#F2FAFA" })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { bg = "NONE", fg = "#F2FAFA" })
end

local rainbow_delimiters_config = function()
    require("rainbow-delimiters.setup").setup({
        strategy = {
            [""] = require("rainbow-delimiters.strategy.global"),
            vim = require("rainbow-delimiters.strategy.local"),
        },
        query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
        },
        priority = {
            [""] = 110,
            lua = 210,
        },
        highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterGreen",
            "RainbowDelimiterOrange",
            "RainbowDelimiterCyan",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterViolet",
        },
    })
end

local auto_tag_config = function()
    require("nvim-ts-autotag").setup({
        opts = {
            -- Defaults
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = true, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {},
    })
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = treesitter_config,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        config = treesitter_textobjects_config,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = treesitter_context_config,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = rainbow_delimiters_config,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "windwp/nvim-ts-autotag",
        config = auto_tag_config,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
