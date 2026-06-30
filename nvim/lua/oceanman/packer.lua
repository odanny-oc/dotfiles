-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- Packer can manage itself
    use 'nvim-lualine/lualine.nvim'
    use 'wbthomason/packer.nvim'
    use { "nvim-lua/plenary.nvim" }
    use { "ThePrimeagen/vim-be-good" }

    use "elentok/encrypt.nvim"

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' }, { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, { "nvim-tree/nvim-web-devicons" }, }
    }
    use {
        "rebelot/kanagawa.nvim",
        -- vim.cmd("colorscheme kanagawa")
    }
    use { "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } }
    use { 'nvim-treesitter/playground' }
    -- use {
    -- "ThePrimeagen/harpoon",
    -- branch = "harpoon2",
    -- requires = { {"nvim-lua/plenary.nvim"} }
    -- }
    use { 'ThePrimeagen/harpoon' }
    use { '/mbbill/undotree' }

    use { 'tpope/vim-fugitive' }

    use { 'stevearc/dressing.nvim' }

    use {
        "williamboman/mason.nvim",
        requires = {
            { "williamboman/mason-lspconfig.nvim" },
        }
    }

    use {
        "neovim/nvim-lspconfig",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "antosha417/nvim-lsp-file-operations" },
            { "folke/neodev.nvim" },
        }
    }
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-buffer" }, { "hrsh7th/cmp-path" }, { "saadparwaiz1/cmp_luasnip" }, { "rafamadriz/friendly-snippets" }, { "onsails/lspkind.nvim" },
        }
    }
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })
    use { "ryanoasis/vim-devicons" }
    use { "theHamsta/nvim-dap-virtual-text" }
    use { "mfussenegger/nvim-dap" }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
    use { "mfussenegger/nvim-dap-python",
        requires = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        } }
    use { "nvim-neotest/nvim-nio" }
    use { "leoluz/nvim-dap-go" }
    use { "m-gail/diagnostic_manipulation.nvim" }
    use { "lervag/vimtex" }
    use { 'tpope/vim-surround' }
    use { 'nvimtools/none-ls.nvim' }
    use { 'kdheepak/lazygit.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    -- config = function()
    --     require("nvim-autopairs").setup {}
    -- end
    }

    -- use { 'moyiz/git-dev.nvim' }
    -- use { 'luk400/vim-jukit' }
end)
