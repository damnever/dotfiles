local config = function()
    local vim = vim

    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    local border = function(hl)
        return {
            { "╭", hl },
            { "─", hl },
            { "╮", hl },
            { "│", hl },
            { "╯", hl },
            { "─", hl },
            { "╰", hl },
            { "│", hl },
        }
    end

    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup({
        view = {
            -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#custom-menu-direction
            entries = { name = 'custom', selection_order = 'top_down', }
        },
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol_text', -- show only symbol annotations
                maxwidth = {
                    -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                    menu = 50,            -- leading text (labelDetails)
                    abbr = 50,            -- actual suggestion item
                },
                ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                -- https://github.com/onsails/lspkind-nvim/pull/30
                before = function(entry, vim_item)
                    return vim_item
                end
            })
        },
        completion = {
            completeopt = 'menu,menuone,noselect',
        },
        preselect = cmp.PreselectMode.None, -- types.cmp.PreselectMode.Item/None
        matching = {
            disallow_fuzzy_matching = false,
            disallow_partial_matching = false,
            disallow_prefix_unmatching = false,
        },
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                -- cmp.config.compare.scopes,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                require("cmp-under-comparator").under,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.kind,
                cmp.config.compare.order,
            },
        },
        performance = {
            debounce = 90,
            throttle = 30,
            fetching_timeout = 200,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
            documentation = {
                border = border("CmpBorder"),
                winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
            },
        },
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- Select/Insert
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            -- Super-Tab like mapping.
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn["vsnip#available"](1) == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            -- { name = 'nvim_lsp_signature_help' },
            -- { name = 'spell' },
            { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
            { name = 'path' },
        }, {
            {
                name = 'buffer',
                option = {
                    keyword_length = 3,
                    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]],
                }
            },
            {
                name = "dictionary",
                keyword_length = 2,
            },
        }),
    })

    -- Set configuration for specific filetype.
    for _, gitft in ipairs({ 'gitcommit', 'gitrebase' }) do
        cmp.setup.filetype(gitft, {
            sources = cmp.config.sources({
                { name = 'cmp_git', }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
                { name = 'buffer' },
                { name = 'dictionary' },
            })
        })
    end

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'nvim_lsp_document_symbol' },
        }, {
            { name = 'buffer' },
        })
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

    local dict = require("cmp_dictionary")
    dict.setup({
        exact_length = 2,
        max_number_items = 3333,
        first_case_insensitive = true,
        document = {
            enable = false,
            command = { "wn", "${label}", "-over" },
        },
        paths = {
            vim.fn.expand("~/.config/_asserts/dict/words_alpha.txt"), -- "/usr/share/dict/words"
        },
    })

    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = 'NONE', fg = '#003366' })

    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
    -- vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#5576a4', fg = 'NONE' })
    -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
    -- gray
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
    -- blue
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
    -- light blue
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
    -- pink
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
    -- front
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
end

return { {
    'hrsh7th/nvim-cmp',
    -- event = "InsertEnter",
    dependencies = {
        { 'hrsh7th/vim-vsnip', dependencies = { 'rafamadriz/friendly-snippets' } },
        { 'hrsh7th/cmp-vsnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'uga-rosa/cmp-dictionary' },
        -- { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
        -- { 'f3fora/cmp-spell' },
        { 'lukas-reineke/cmp-under-comparator' },
        { 'onsails/lspkind.nvim' },
    },
    config = config,
} }
