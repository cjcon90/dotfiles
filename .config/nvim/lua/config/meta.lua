local M = {}
M.is_meta = (vim.uv or vim.loop).os_gethostname():match("^devvm") ~= nil
return M
