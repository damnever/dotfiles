local config = function()
    require('lib').vimbatch.global_vars({
        ["conjure#mapping#doc_word"] = false
    })
end

return { {
    "Olical/conjure",
    ft = { "clojure", "janet", "python" }, -- etc
    lazy = true,
    enabled = false,
    config = config,
} }
