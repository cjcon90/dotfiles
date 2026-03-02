return {
  {
    "stevearc/oil.nvim",
    opts = {
      columns = { "icon" },
      keymaps = {
        ["h"] = "actions.parent",
        ["l"] = "actions.select",
      },
    },
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  },
}
