return {
  {
    "aznhe21/actions-preview.nvim",
    keys = {
      { "<Leader>ca", function() require("actions-preview").code_actions() end, mode = { "v", "n" }, desc = "Code Action Preview" },
    },
  },
}
