local opts = { noremap = true, silent = true }
local function nmap(keymap, action)
    vim.keymap.set("n", keymap, action, opts)
end

vim.g.mapleader = " "

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'D', ':lua NetrwTrash()<CR>', { noremap = true, silent = true })
  end,
})

nmap("<Esc>", vim.cmd.q)

nmap("<leader><A-t>", vim.cmd.term)

--Window movement and resizing
nmap("<A-=>", "<C-w>+")
nmap("<A-->", "<C-w>-")
nmap("<A-[>", "<C-w>>")
nmap("<A-]>", "<C-w><")

nmap("<A-J>", "<C-w>J")
nmap("<A-K>", "<C-w>K")
nmap("<A-L>", "<C-w>L")
nmap("<A-H>", "<C-w>H")

nmap("<A-t>", "<C-w>t")
nmap("<A-d>", "<C-w>b")

nmap("<A-j>", "<C-w>j")
nmap("<A-k>", "<C-w>k")
nmap("<A-l>", "<C-w>l")
nmap("<A-h>", "<C-w>h")

nmap("<A-Left>", vim.cmd.Vex)
nmap("<A-Up>", vim.cmd.Sex)
nmap("<leader>pr", vim.cmd.Rex)
nmap("<A-e>", vim.cmd.only)

nmap("<leader>cd", ":cd %:h <CR>")

nmap("<leader>lg", vim.cmd.LazyGit)

vim.keymap.set("n", "<A-w>", "<C-w>w", opts)

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("i", "KJ", "<Esc>")
vim.keymap.set("t", "kj", "<LeftMouse>gg$")

--move selected lines in V
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--maintain centre cursor for cut to line jump half page and search
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "n", "nzzzv")

--copy paste over without loosing paste
vim.keymap.set("x", "<leader>p", "\"_dP")

--copy to reg and os clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>v", vim.cmd.reg, opts)

--find and replace text in previously selected region (g = all occurances, /* from line start, i = case sensitive)
vim.keymap.set("n", "<leader><C-r>", function()
    local word = vim.fn.expand("<cword>")
    return ":%s/" .. word
end, { expr = true }
)

vim.keymap.set("v", "<C-r>", function()
    local word = vim.fn.expand("<cword>")
    return ":s/" .. word
end, { expr = true }
)


vim.keymap.set("n", "<leader>gt", ":tabn<CR>", opts)
vim.keymap.set("n", "<leader>gr", ":tabp<CR>", opts)

vim.keymap.set("n", "<leader>gn", ":tabnew ~/.config/nvim<CR>", opts)
vim.keymap.set("n", "<leader>gq", ":tabo<CR>", opts)
vim.keymap.set("n", "<leader><C-w>", ":tabc<CR>", opts)

vim.keymap.set('n', '<C-w>', '<C-e>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-w>', '<C-e>', { noremap = true, silent = true })
--Show all diagnostic messages
vim.keymap.set('n', 'gK', function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.keymap.set('n', '<leader>c', vim.cmd.noh, opts)
-- vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float())

--"Show LSP references"
--vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

--"Go to declaration"
--vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
--
-- --"Show LSP definitions"
--vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
--
-- --"Show LSP implementations"
--vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
--
-- --"Show LSP type definitions"
--vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
--
-- --"See available code actions"
--vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
--
-- --"Smart rename"
--vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
--
-- --"Show buffer diagnostics"
--vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
--
-- --"Show line diagnostics"
--vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
--
-- --"Go to previous diagnostic"
--vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
--
-- --"Go to next diagnostic"
--vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
--
-- --"Show documentation for what is under cursor"
--vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
--
----"Restart LSP"
--vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
