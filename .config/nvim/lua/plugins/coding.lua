return {
  -- Disable mini.pairs (autoclose.nvim replaces it)
  { "nvim-mini/mini.pairs", enabled = false },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        python          = { "ruff_format", "ruff_organize_imports" },
        go              = { "goimports", "gofumpt" },
        rust            = { "rustfmt" },
        sh              = { "shfmt" },
        bash            = { "shfmt" },
        lua             = { "stylua" },
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        css             = { "prettier" },
        scss            = { "prettier" },
        html            = { "prettier" },
        json            = { "prettier" },
        jsonc           = { "prettier" },
        yaml            = { "prettier" },
        markdown        = { "prettier" },
        toml            = { "taplo" },
      },
      format_on_save = {
        timeout_ms = 2500,
        lsp_fallback = true,
      },
    },
  },
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
