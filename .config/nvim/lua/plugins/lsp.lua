-- Servers without npm (NAS, work devserver) lack Mason's toolchains: use what's installed, never auto-install
local no_autoinstall = vim.fn.executable("npm") == 0

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
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if not no_autoinstall then
        return
      end
      for name, s in pairs(opts.servers) do
        if s == true then
          opts.servers[name] = { mason = false }
        elseif type(s) == "table" then
          s.mason = false
        end
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if no_autoinstall then
        opts.ensure_installed = {}
      end
    end,
  },
}
