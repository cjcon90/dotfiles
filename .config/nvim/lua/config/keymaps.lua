local opts = { noremap = true, silent = true }

-- Window navigation
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
vim.keymap.set("n", "<S-l>", ":bnext<cr>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<cr>", opts)

-- Insert mode escape
vim.keymap.set("i", ";a", "<Esc>", opts)

-- Visual mode indent (stay in visual)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Retain yank after paste in visual
vim.keymap.set("v", "p", '"_dP', opts)

-- Terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })
