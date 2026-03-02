return {
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        width = 120,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
        },
      },
      plugins = {
        gitsigns = { enabled = true },
        tmux = { enabled = true },
      },
    },
  },
}
