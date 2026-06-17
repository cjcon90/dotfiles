local opts = { noremap = true, silent = true }

-- Better up/down on wrapped lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search highlight on escape
vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true })

-- Undo breakpoints in insert mode
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Window navigation (LazyVim defaults are disabled via defaults.keymaps = false)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Window resize
vim.keymap.set("n", "<C-Up>", ":resize +2<cr>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -2<cr>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- Buffer navigation
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", opts)
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", opts)

-- Insert mode escape
vim.keymap.set("i", ";a", "<Esc>", opts)

-- Visual mode indent (stay in visual)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Retain yank after paste in visual
vim.keymap.set("v", "p", '"_dP', opts)

-- Unmap <C-b> so it passes through to tmux
vim.keymap.set({ "n", "v" }, "<C-b>", "<Nop>", opts)

-- LSP navigation (override snacks picker with standard vim.lsp.buf)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local bopts = { buffer = buf, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bopts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bopts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bopts)
  end,
})
