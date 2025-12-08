return {
  {
    "ojroques/nvim-osc52",
    event = "VeryLazy",
    config = function()
      require("osc52").setup()
      vim.keymap.set("v", "<leader>y", require("osc52").copy_visual, { silent = true, noremap = true })
    end,
  },
}
