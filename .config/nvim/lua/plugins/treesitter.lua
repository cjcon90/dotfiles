return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      -- Required by LazyVim; everything else is installed on first open via auto_install
      ensure_installed = {
        "lua", "luadoc", "luap", "vim", "vimdoc", "query",
        "markdown", "markdown_inline", "diff", "regex",
      },
      highlight = { enable = true, disable = { "dockerfile" } },
      indent = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "#6272a4" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- No C compiler (servers) means parsers can't build: skip installs instead of warning on every start
    opts = function(_, opts)
      if vim.fn.executable("cc") == 0 then
        opts.ensure_installed = {}
      end
    end,
  },
}
