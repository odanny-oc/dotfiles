require("oceanman.lsp.mason")
require("nvim-dap-virtual-text").setup {}
local lspconfig = vim.lsp.config()
local def = require "oceanman.lsp.default-lsp"

lspconfig.lua_ls.setup {
    autostart = true,
    capabilities = def.capabilities,
    on_attach = def.on_attach,
    signatureHelp = { enable = true },

    require 'lspconfig'.lua_ls.setup {
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                        -- Depending on the usage, you might want to add additional paths here.
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                    }
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                }
            })
        end,
        settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
            }
        }
    },

    lspconfig.pyright.setup {
        autostart = true,
        root_dir = "~/.config/nvim",
        cmd = { "pyright-langserver", "--stdio" },
        on_attach = def.on_attach,
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        capabilities = def.capabilities,
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true
                },
            },
        },
    },

    -- lspconfig.texlab.setup {
    --     cmd = { "texlab" },
    --     filetypes = { "tex", "plaintex", "bib" },
    --     on_attach = def.on_attach,
    --     root_markers = { ".git", ".latexmkrc", "latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
    --     settings = {
    --         texlab = {
    --             bibtexFormatter = "texlab",
    --             build = {
    --                 args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
    --                 executable = "latexmk",
    --                 forwardSearchAfter = false,
    --                 onSave = false
    --             },
    --             chktex = {
    --                 onEdit = false,
    --                 onOpenAndSave = false
    --             },
    --             diagnosticsDelay = 300,
    --             formatterLineLength = 80,
    --             forwardSearch = {
    --                 args = {}
    --             },
    --         }
    --     }
    -- }

}
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
