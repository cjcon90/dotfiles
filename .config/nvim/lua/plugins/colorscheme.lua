return {
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true,
      italic_comment = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "dracula" },
  },
}
