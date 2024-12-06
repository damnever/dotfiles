local config = function()
    require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt" },
        disable_in_macro = false,       -- disable when recording or executing a macro
        disable_in_visualblock = false, -- disable when insert after visual block mode
        ignored_next_char = [=[[%w%%%'%[%"%.]]=],
        enable_moveright = true,
        enable_afterquote = false,        -- add bracket pairs after quote
        enable_check_bracket_line = true, --- check bracket in same line
        enable_bracket_in_quote = true,   --
        enable_abbr = false,              -- trigger abbreviation
        break_undo = true,                -- switch for basic rule break undo sequence
        check_ts = false,
        map_cr = true,
        map_bs = true,   -- map the <BS> key
        map_c_h = false, -- Map the <C-h> key to delete a pair
        map_c_w = false, -- map <c-w> to delete a pair if possible
    })

    require("nvim-autopairs").get_rule("'")[1].not_filetypes = { "scheme", "lisp" }

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local handlers = require('nvim-autopairs.completion.handlers')
    local utils = require('nvim-autopairs.utils')
    local cmp = require('cmp')
    local Kind = cmp.lsp.CompletionItemKind
    -- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done())
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done({
            filetypes = {
                lisp = {
                    ["("] = {
                        kind = { Kind.Function, Kind.Method },
                        handler = handlers.lisp
                    }
                },
                scheme = {
                    ["("] = {
                        kind = { Kind.Function, Kind.Method },
                        handler = handlers.lisp
                    }
                },
                go = {
                    ["("] = {
                        kind = { Kind.Function, Kind.Method },
                        handler = handlers["*"]
                    }
                },
            }
        })
    )
end


return { {
    'windwp/nvim-autopairs',
    dependencies = 'nvim-cmp',
    config = config,
} }
