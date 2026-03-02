return {
  {
    "m4xshen/autoclose.nvim",
    opts = {
      options = {
        disabled_filetypes = { "text" },
        disable_when_touch = true,
        pair_spaces = true,
      },
      keys = {
        ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { "markdown" } },
        ["`"] = { escape = false, close = true, pair = "``" },
        ["<"] = { escape = false, close = true, pair = "<>", enabled_filetypes = { "rust" } },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    init = function()
      vim.g.nvim_surround_no_normal_mappings = true
      vim.keymap.set("n", "gs", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
      vim.keymap.set("n", "gss", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround line" })
    end,
    opts = {},
  },
}
