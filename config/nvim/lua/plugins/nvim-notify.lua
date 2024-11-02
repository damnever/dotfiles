local config = function()
    local notify = require("notify")
    notify.setup({
        level = "INFO", -- "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "OFF"
        timeout = 2000, -- 2s
        -- max_width = ,
        -- max_height = ,
        stages = "fade_in_slide_out", -- "fade_in_slide_out", "fade", "slide", "static"
        -- background_colour = "Normal",
        icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
        },
        on_open = nil,
        on_close = nil,
        render = "default",
        minimum_width = 50,
        fps = 30,
    })

    vim.notify = notify
end

return { {
    'rcarriga/nvim-notify',
    config = config,
} }
