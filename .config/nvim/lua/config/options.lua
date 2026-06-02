local options = {
  backup = false,
  clipboard = "",
  cmdheight = 2,
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = false,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 1,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 300,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  smoothscroll = true,
  guifont = "monospace:h17",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.whichwrap:append("<,>,[,],h,l")

-- Scope `-` as part of a word only for relevant filetypes (CSS/HTML/JSX)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css", "scss", "html", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.iskeyword:append("-")
  end,
})

-- Disable unnamedplus so y/p use Neovim registers only.
-- Must run after LazyVim's deferred clipboard restore.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.schedule(function()
      vim.opt.clipboard = ""
    end)
  end,
})

-- OSC 52 clipboard (works over SSH/tmux)
if vim.fn.executable("wl-paste") == 1 then
  vim.g.clipboard = {
    name = "osc52-wlpaste",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = { "wl-paste", "--no-newline" },
      ["*"] = { "wl-paste", "--no-newline", "--primary" },
    },
  }
else
  vim.g.clipboard = "osc52"
end
