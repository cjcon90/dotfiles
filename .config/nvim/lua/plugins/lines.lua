return {
   {
      "lukas-reineke/virt-column.nvim",
      opts = {},
   },
   {
      "m4xshen/smartcolumn.nvim",
      opts = {
         disabled_filetypes = {
            "netrw",
            "NvimTree",
            "Lazy",
            "mason",
            "help",
            "text",
            "markdown",
            "tex",
            "html",
         },
         scope = "window",
      },
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
         options = {
            theme = "dracula",
            globalstatus = true,
         },
         sections = {
            lualine_c = {},
         },
      },
      init = function()
         vim.opt.showmode = false
      end,
   },
   {
      "akinsho/bufferline.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
      },
   },
   {
      "utilyre/barbecue.nvim",
      name = "barbecue",
      version = "*",
      theme = "dracula",
      dependencies = {
         "SmiteshP/nvim-navic",
         "nvim-tree/nvim-web-devicons",
      },
      opts = {
         show_dirname = false,
         show_basename = false,
      },
   },
}
