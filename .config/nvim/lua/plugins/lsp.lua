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
      diagnostics = {
        virtual_text = {
          format = function(diagnostic)
            local new_line_location = diagnostic.message:find("\n")
            if new_line_location ~= nil then
              return diagnostic.message:sub(1, new_line_location)
            else
              return diagnostic.message
            end
          end,
        },
      },
      format = { timeout_ms = 2500 },
    },
  },
}
