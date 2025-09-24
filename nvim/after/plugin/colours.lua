require("kanagawa").setup({
    overrides = function(colors)
        return {
            StatusLine = { fg = colors.palette.surimiOrange, bold= true, bg = colors.palette.dragonBlack4 },
        }
    end,
})

function ColourMyPencils(colour)
    colour = colour or "kanagawa"
    vim.cmd.colorscheme(colour)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColourMyPencils()
