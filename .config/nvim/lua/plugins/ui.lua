return {
   {
    	"Mofiqul/dracula.nvim",
    	name = "dracula",
    	lazy = false,
    	priority = 1000,
    	config = function()
    	  require("dracula").setup({})
    	  vim.cmd.colorscheme "dracula"
    	end,
   },
   {
      "rcarriga/nvim-notify",
      opts = {},
      config = function()
         vim.notify = require("notify")
      end,
   },
   {
      "aznhe21/actions-preview.nvim",
      config = function()
         vim.keymap.set(
            { "v", "n" },
            "<Leader>ca",
            require("actions-preview").code_actions
         )
      end,
   },
}
