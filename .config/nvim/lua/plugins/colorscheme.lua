return {
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true,
      italic_comment = true,
      overrides = function(colors)
        local border = { fg = colors.purple, bg = colors.bg }
        local title = { fg = colors.pink, bg = colors.bg, bold = true }
        return {
          -- dracula.nvim leaves the winbar on nvim's near-black default
          WinBar = { bg = "NONE" },
          WinBarNC = { bg = "NONE" },
          FloatBorder = border,
          FloatTitle = title,
          TelescopeBorder = border,
          TelescopePromptBorder = border,
          TelescopeResultsBorder = border,
          TelescopePreviewBorder = border,
          TelescopeTitle = title,
          TelescopePromptTitle = title,
          TelescopeResultsTitle = title,
          TelescopePreviewTitle = title,
          WhichKeyBorder = border,
          NoiceCmdlinePopupBorder = border,
          NoiceCmdlinePopupTitle = title,
          CursorLineNr = { fg = colors.purple, bold = true },
          -- dracula.nvim's own bufferline colours win over bufferline's opts
          BufferLineFill = { bg = "NONE" },
          BufferLineSeparator = { fg = "NONE" },
          BufferLineBufferSelected = { fg = colors.purple, bg = colors.selection, bold = true },
          BufferLineIndicatorSelected = { fg = colors.purple, bg = colors.selection },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "dracula" },
  },
}
