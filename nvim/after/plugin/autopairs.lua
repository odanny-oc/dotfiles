require("nvim-autopairs").setup {}

local autopairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

autopairs.add_rules({
  Rule("$", "$", {"tex", "latex"})
    -- Don't pair if the cursor is right after a backslash (escaped \$)
    :with_move(cond.not_after_text("\\"))
    -- Don't pair if the next character is already a $
    :with_pair(cond.not_after_regex([=[%$]=]))
})
