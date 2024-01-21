return {
   {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      init = function()
         local builtin = require("telescope.builtin")
         vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
         vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
         vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
         vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      end,
   },
   {
      "numToStr/FTerm.nvim",
      init = function()
         require("FTerm").setup({
            dimensions = {
               height = 0.9,
               width = 0.9,
            },
            vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true }),
         })
      end
   }
}
