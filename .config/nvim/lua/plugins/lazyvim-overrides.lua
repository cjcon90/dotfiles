-- Disable LazyVim's default leader keymaps from plugins.
-- Our keymaps are defined in plugins/keymaps.lua via which-key.
-- Core LazyVim keymaps are disabled via defaults.keymaps = false in lazy.lua.

return {
  -- ── Snacks (picker / explorer / notifications) ──────────────────
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>,", false },
      { "<leader>/", false },
      { "<leader>:", false },
      { "<leader><space>", false },
      { "<leader>.", false },
      { "<leader>n", false },
      { "<leader>e", false },
      { "<leader>E", false },
      -- file
      { "<leader>fb", false },
      { "<leader>fB", false },
      { "<leader>fc", false },
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fg", false },
      { "<leader>fm", false },
      { "<leader>fM", false },
      { "<leader>fp", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      -- git
      { "<leader>gd", false },
      { "<leader>gD", false },
      { "<leader>gs", false },
      { "<leader>gS", false },
      { "<leader>gi", false },
      { "<leader>gI", false },
      { "<leader>gp", false },
      { "<leader>gP", false },
      -- search
      { "<leader>sb", false },
      { "<leader>sB", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sp", false },
      { "<leader>sw", false, mode = { "n", "x" } },
      { "<leader>sW", false, mode = { "n", "x" } },
      { '<leader>s"', false },
      { "<leader>s/", false },
      { "<leader>sa", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>si", false },
      { "<leader>sj", false },
      { "<leader>sk", false },
      { "<leader>sl", false },
      { "<leader>sm", false },
      { "<leader>sM", false },
      { "<leader>sR", false },
      { "<leader>sq", false },
      { "<leader>ss", false },
      { "<leader>sS", false },
      { "<leader>su", false },
      -- ui
      { "<leader>uC", false },
      { "<leader>un", false },
    },
  },

  -- ── Which-key (remove LazyVim's default groups) ─────────────────
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = {}
    end,
    keys = {
      { "<leader>?", false },
    },
  },

  -- ── Trouble (we use <leader>t*, not <leader>x*/<leader>c*) ──────
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", false },
      { "<leader>xX", false },
      { "<leader>cs", false },
      { "<leader>cS", false },
    },
  },

  -- ── LSP (we use <leader>l*, not <leader>c*) ────────────────────
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<leader>ca", false },
      { "<leader>cc", false },
      { "<leader>cC", false },
      { "<leader>cR", false },
      { "<leader>cr", false },
      { "<leader>cA", false },
      { "<leader>co", false },
      { "<leader>cl", false },
      { "<leader>ss", false },
      { "<leader>sS", false },
    },
  },
  { "mason-org/mason.nvim", keys = { { "<leader>cm", false } } },

  -- ── Bufferline (we use S-h/S-l, <leader>c for close) ───────────
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bp", false },
      { "<leader>bP", false },
      { "<leader>br", false },
      { "<leader>bl", false },
      { "<leader>bj", false },
      { "<leader>be", false },
    },
  },

  -- ── DAP (not used) ───────────────────────────────────────────────
  { "mfussenegger/nvim-dap", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "theHamsta/nvim-dap-virtual-text", enabled = false },

  -- ── Venv Selector (requires fd, not available on Meta) ───────────
  { "linux-cultist/venv-selector.nvim", enabled = not require("config.meta").is_meta },

  -- ── Noice ───────────────────────────────────────────────────────
  {
    "folke/noice.nvim",
    keys = {
      { "<leader>sn", false },
      { "<leader>snl", false },
      { "<leader>snh", false },
      { "<leader>sna", false },
      { "<leader>snd", false },
      { "<leader>snt", false },
    },
  },
}
