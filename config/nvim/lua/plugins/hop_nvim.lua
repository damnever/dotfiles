local config = function()
    require('hop').setup({
        keys = 'qweruiopasdfghjklcn',
    })

    require('lib').vimbatch.keymaps({
        {
            mode = '',
            lhs = 'f',
            rhs = function()
                require('hop').hint_char1({
                    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
                    current_line_only = true,
                })
            end
        },
        {
            mode = '',
            lhs = 'F',
            rhs = function()
                require('hop').hint_char1({
                    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
                    current_line_only = true,
                })
            end
        },
        {
            mode = '',
            lhs = 't',
            rhs = function()
                require('hop').hint_char1({
                    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
                    current_line_only = true,
                    hint_offset = -1,
                })
            end
        },
        {
            mode = '',
            lhs = 'T',
            rhs = function()
                require('hop').hint_char1({
                    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
                    current_line_only = true,
                    hint_offset = -1,
                })
            end
        },
        { mode = '', lhs = '<leader><leader>g', rhs = function() require('hop').hint_lines() end },
        { mode = '', lhs = '<leader><leader>w', rhs = function() require('hop').hint_words() end },
    })
end


return { {
    'phaazon/hop.nvim',
    event = "BufReadPost",
    config = config,
} }
