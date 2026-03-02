local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local is_meta = require("config.meta").is_meta

local spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
}

-- Meta-specific plugin specs (must come after lazyvim.plugins, before extras and user plugins)
if is_meta then
  table.insert(spec, {
    dir = "/usr/share/fb-editor-support/nvim",
    name = "meta.nvim",
    import = "meta.lazyvim",
  })
  table.insert(spec, { import = "lazyvim.plugins.extras.lsp.none-ls" })
end

-- User plugins last
table.insert(spec, { import = "plugins" })

require("lazy").setup({
  spec = spec,
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "dracula", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
