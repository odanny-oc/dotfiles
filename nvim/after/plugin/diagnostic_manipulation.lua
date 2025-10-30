require("diagnostic_manipulation").setup {
    blacklist = {
        function(diagnostic)
            return string.find(diagnostic.message, "Undefined global `vim`")
        end,
        function (diagnostic)
            return string.find(diagnostic.message, 'is not a known attribute of module "astropy.constants"')
        end,
        function (diagnostic)
           return string.find(diagnostic.message,'"list[float]" is not assignable to "ndarray[Any, dtype[floating[Unknown]]]" [reportArgumentType]')
        end,
        --require("diagnostic_manipulation.builtin.tsserver").tsserver_codes({ 6133, 6196 })
    },
    whitelist = {
        -- Your whitelist here
    }
}
