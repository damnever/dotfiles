local config = function()
    vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { link = 'IncSearch' })
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

    require("lsp_signature").setup({
        doc_lines = 0,
        max_height = 14,
        max_width = 80,
        wrap = true,
        floating_window_above_cur_line = true,
        -- floating_window_off_x = 1,
        -- floating_window_off_y = -2,
        close_timeout = 2000,
        hint_enable = false,
        hi_parameter = 'LspSignatureActiveParameter',
        handler_opts = {
            -- double, rounded, single, shadow, none, or a table of borders
            border = border("CmpBorder"),
        },
        fix_pos = false,
        padding = '',
        timer_interval = 200,
        always_trigger = false,
    })
end

return { {
    -- NOTE: disable 'hrsh7th/cmp-nvim-lsp-signature-help' in ./lsp_cmp.lua
    'ray-x/lsp_signature.nvim',
    config = config,
} }