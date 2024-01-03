return {
   {
      "sbdchd/neoformat",
      config = function()
         vim.g.neoformat_try_node_exe = 1
      end,
      keys = {
         { "<Leader>fm", ":Neoformat<CR>" },
      },
   },
   {
      "ojroques/vim-oscyank",
      config = function()
         -- Define a function to yank selected text to the system clipboard using OSCYankVisual
         local function oscyankvisual()
            vim.api.nvim_command("silent! OSCYankVisual *")
         end
         -- Map Ctrl+Shift+C to the oscyankvisual function in visual mode
         vim.api.nvim_command([[autocmd FileType * vnoremap <C-S-C> :lua oscyankvisual()<CR>]])
      end


   },
   {
      "tpope/vim-sleuth",
   },
   {
      "nacro90/numb.nvim",
      opts = {},
   },
   {
      "numToStr/Comment.nvim",
      opts = {},
   },
   {
      "norcalli/nvim-colorizer.lua",
      config = function()
         require("colorizer").setup()
      end,
   },
   {
      "roobert/tailwindcss-colorizer-cmp.nvim",
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
         local exclude_ft = { "help", "git", "markdown", "snippets", "text", "gitconfig", "alpha", "dashboard" }
         require("ibl").setup({
            indent = {
               -- -- U+2502 may also be a good choice, it will be on the middle of cursor.
               -- -- U+250A is also a good choice
               char = "▏",
            },
            scope = {
               show_start = false,
               show_end = false,
            },
            exclude = {
               filetypes = exclude_ft,
               buftypes = { "terminal" },
            },
         })
      end,
   },
}
