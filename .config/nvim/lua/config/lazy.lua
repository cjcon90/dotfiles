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

local spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = { defaults = { keymaps = false } } },
}

-- Optional work overlay plugin specs (must come after lazyvim.plugins, before extras and user plugins)
local has_work = (vim.uv or vim.loop).fs_stat(vim.fn.stdpath("config") .. "/lua/work/init.lua")
if has_work then
  table.insert(spec, { import = "work.plugins" })
end

-- Language extras assume their toolchains; servers without npm (NAS) or with only a stub npm (work devserver) skip them
vim.g.has_toolchains = vim.fn.executable("npm") == 1 and not has_work
if vim.g.has_toolchains then
  for _, extra in ipairs({
    "formatting.black",
    "lang.go",
    "lang.json",
    "lang.markdown",
    "lang.python",
    "lang.rust",
    "lang.sql",
    "lang.toml",
    "lang.typescript",
    "lang.yaml",
  }) do
    table.insert(spec, { import = "lazyvim.plugins.extras." .. extra })
  end
end

-- User plugins last
table.insert(spec, { import = "plugins" })

require("lazy").setup({
  spec = spec,
  defaults = {
    version = false,
  },
  install = { colorscheme = { "dracula", "habamax" } },
  ui = { border = "rounded" },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
