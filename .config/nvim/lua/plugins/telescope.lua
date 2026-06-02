return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      pickers = {
        find_files = {
          find_command = vim.fn.executable("fd") == 1
            and { "fd", "--type", "f", "--strip-cwd-prefix" }
            or { "find", ".", "-type", "f" },
        },
      },
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
    },
  },
}
