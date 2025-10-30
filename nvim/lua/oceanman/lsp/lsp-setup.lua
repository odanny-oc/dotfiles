require("oceanman.lsp.mason")
require("nvim-dap-virtual-text").setup {}
local def = require "oceanman.lsp.default-lsp"


vim.lsp.config('lua_ls', {
  autostart = true,
  capabilities = def.capabilities,
  on_attach = def.on_attach,
  signatureHelp = { enable = true },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})


vim.lsp.config('pyright', {
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
    })

vim.lsp.enable('pyright')
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


local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
