return {
   {
      "sbdchd/neoformat",
      config = function()
         vim.g.neoformat_try_node_exe = 1
      end,
      keys = {
         { "<Leader>fm", ":Neoformat<CR>" },
      },
   },
   {
      "tpope/vim-sleuth",
   },
   {
      "nacro90/numb.nvim",
      opts = {},
   },
   {
      "numToStr/Comment.nvim",
      opts = {},
   },
   {
      "norcalli/nvim-colorizer.lua",
      config = function()
         require("colorizer").setup()
      end,
   },
   {
      "roobert/tailwindcss-colorizer-cmp.nvim",
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
         require("ibl").setup()
      end,
   },
}
