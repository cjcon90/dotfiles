return {
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    keys = {
      { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Code Outline" },
    },
    opts = {
      backends = { "lsp", "treesitter" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 2500 },
    },
  },
}
