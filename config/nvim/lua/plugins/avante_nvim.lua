local config = function()
    require("avante").setup({
        provider = "copilot",
        providers = {
            openai = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
                timeout = 30000, -- timeout in milliseconds
                extra_request_body = {
                    temperature = 0, -- adjust if needed
                    max_tokens = 4096,
                },
            },
        },
        behaviour = {
            auto_suggestions = false,
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true,
            enable_token_counting = true,
        },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = "right",
            wrap = true,
            width = 40,
            sidebar_header = {
                enabled = true, -- true, false to enable/disable the header
                align = "left", -- left, center, right for title
                rounded = true,
            },
        }
    })

    vim.api.nvim_set_hl(0, 'AvanteInlineHint', { link = 'Whitespace' })
end

return { {
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    config = config,
    build = "env CARGO_NET_GIT_FETCH_WITH_CLI=true make BUILD_FROM_SOURCE=true",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- optional
        "echasnovski/mini.pick",  -- for file_selector provider mini.pick
        "ibhagwan/fzf-lua",       -- for file_selector provider fzf
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "Avante" },
            },
            ft = { "Avante" },
        },
    },
} }
