local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    filetypes = { "python" },
    sources = {
        --null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.black,
    },
})
