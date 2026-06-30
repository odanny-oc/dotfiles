require('lualine').setup({
  options = {
    icons_enabled = true, -- Make sure this is true
    theme = 'auto',       -- Or your preferred theme
    -- ... other options
  },
  sections = {
    lualine_x = {
      {
        'diagnostics',
        -- Table of version control identifiers
        sources = { 'nvim_diagnostic' },
        -- Displays diagnostics for the defined severity types
        sections = { 'error', 'warn', 'info', 'hint' },
        -- Update the symbols here to use your preferred Nerd Font glyphs
        symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
        colored = true,           -- Displays diagnostics status in color rather than the list outline color
        update_in_insert = false, -- Only update diagnostics in normal mode
        always_visible = false,   -- Show diagnostics even if there are none
      }
    }
  }
})
