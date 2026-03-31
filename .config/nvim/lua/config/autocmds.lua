local is_meta = require("config.meta").is_meta

-- Only highlight when searching
vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    local cmd = vim.v.event.cmdtype
    if cmd == "/" or cmd == "?" then
      vim.opt.hlsearch = true
    end
  end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    local cmd = vim.v.event.cmdtype
    if cmd == "/" or cmd == "?" then
      vim.opt.hlsearch = false
    end
  end,
})

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions = { c = false, r = false, o = false }
  end,
})

-- Turn on spell check and wrap for markdown/tex files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Filetype-specific run keymaps (buffer-local)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.go" },
  callback = function()
    vim.keymap.set("n", "<Leader>x", ":terminal go run %<CR>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py" },
  callback = function()
    vim.keymap.set("n", "<Leader>x", ":terminal python3 %<CR>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.cpp", "*.cc" },
  callback = function()
    vim.keymap.set("n", "<Leader>x", ":terminal ./a.out<CR>", { silent = true, buffer = true })
  end,
})

-- Fix WinBar (barbecue) background with transparent Dracula theme
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "WinBar",   { bg = "#282a36", fg = "#f8f8f2" })
    vim.api.nvim_set_hl(0, "WinBarNC", { bg = "#282a36", fg = "#6272a4" })
  end,
})

-- Meta-only: Disable GetCodehubLink command (keep only GetCodehubLinkYank)
if is_meta then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      pcall(vim.api.nvim_del_user_command, "GetCodehubLink")
    end,
  })
end
