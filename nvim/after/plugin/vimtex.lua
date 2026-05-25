local opts = { silent = true, noremap = true }
-- Basic VimTeX setup
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')

-- Viewer configuration
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
-- Alternative viewer configuration:
-- vim.g.vimtex_view_general_viewer = 'okular'
-- vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

-- Compiler configuration with shell-escape enabled
vim.g.vimtex_compiler_latexmk = {
    options = {
        '-pdf',
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

-- Set the local leader key
vim.g.maplocalleader = ","

vim.g.vimtex_format_enabled = 1

vim.keymap.set("n", "<C-j>", ":VimtexError<CR>:w<CR>")
vim.keymap.set("n", "<localleader>mm", ":w<CR>:VimtexCompileMulti<CR>")
