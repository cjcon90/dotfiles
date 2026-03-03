return {
  { "lukas-reineke/virt-column.nvim", opts = {}, version = "*" },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      disabled_filetypes = { "netrw", "NvimTree", "Lazy", "mason", "help", "text", "markdown", "tex", "html" },
      scope = "window",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "dracula", globalstatus = true },
      sections = { lualine_c = {} },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "dracula",
      show_dirname = false,
      show_basename = false,
    },
  },
}
