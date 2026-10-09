-- Optional work overlay (untracked): lua/work/. Loaded first so it can set up
-- the environment (e.g. proxy) before lazy.nvim runs
local has_work, work = pcall(require, "work")
if not has_work and not tostring(work):find("module 'work' not found", 1, true) then
  vim.notify("work: " .. tostring(work), vim.log.levels.ERROR)
end

require("config.utils")
require("config.lazy")

-- Diagnostic configuration (always loaded)
require("config.diagnostics")

-- Work overlay post-setup (commands, LSP, extensions)
if has_work then
  work.setup()
end

-- Machine-local overrides (untracked): lua/config/local.lua
local ok, err = pcall(require, "config.local")
if not ok and not tostring(err):find("module 'config.local' not found", 1, true) then
  vim.notify("config.local: " .. tostring(err), vim.log.levels.ERROR)
end
