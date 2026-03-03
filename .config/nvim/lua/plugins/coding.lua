return {
  -- Disable mini.pairs (autoclose.nvim replaces it)
  { "nvim-mini/mini.pairs", enabled = false },
  -- Disable conform.nvim (using <leader>lf with vim.lsp.buf.format / arc f instead)
  { "stevearc/conform.nvim", enabled = false },
  { "tpope/vim-sleuth" },
  { "nacro90/numb.nvim", opts = {} },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          suppress_deprecation = true,
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "▏" },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha", "dashboard" },
        buftypes = { "terminal" },
      },
    },
  },
}
