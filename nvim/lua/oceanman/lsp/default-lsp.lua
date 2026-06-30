local M = {}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.log.set_level(vim.log.levels.WARN)

M.on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = true })
    end

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    nmap("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Go to previous diagnostic message")
    nmap("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Go to next diagnostic message")
    --vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")

    --nmap("<leader>r", ":w <CR> :tab term python %<CR>", "Run Python File")
    nmap("<leader>r", ":w<CR>:3split term://cd %:p:h && python %:p<CR> <A-j>", "Run Python File")
    nmap("<leader>q", ":bufdo if &buftype == 'terminal' | bwipeout! | endif <CR>", "Kill Terminals Python")
    nmap("<A-q>", ":only<CR> :w <CR> :bufdo if &buftype == 'terminal' | bwipeout! | endif <CR>", "Kill Terminals Python")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "Open Definition in Vertical Split")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>Ic", vim.lsp.buf.incoming_calls, "[I]ncoming [C]alls")
    nmap("<leader>Oc", vim.lsp.buf.outgoing_calls, "[O]utgoing [C]alls")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>s", vim.diagnostic.open_float, "Open diagnostic under cursor") -- show diagnostics for line
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    nmap("<A-f>", vim.lsp.buf.format)

    -- Lesser used LSP functionality
    nmap("<leader>wA", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")



    nmap("<leader>db", ":DapToggleBreakpoint <CR>")
    nmap("<leader>dbr", ":lua require('dap-python').test_method() <CR>")
    nmap("<A-b>", ":lua require('dapui').toggle()<CR>")
    nmap("<leader>dbc", ":lua require('dap').continue()<CR>")

    nmap("<leader>dbs", ":lua require('dap').step_over()<CR>")
    nmap("<leader><CR>", ":lua require('dap').step_into()<CR>")
    nmap("<leader>dbe", ":lua require('dap').step_out()<CR>")

    nmap("<leader>dbc", ":lua require('dap').continue()<CR>")

    nmap("<leader>br", require("dap").toggle_breakpoint, "Toggle Breakpoint")
    print("Attached to Buffer")
end

return M
