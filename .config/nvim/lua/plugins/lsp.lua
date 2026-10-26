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
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if not vim.g.has_toolchains then
        opts.ensure_installed = {}
      end
    end,
  },
}
