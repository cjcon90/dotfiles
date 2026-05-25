local opts = { noremap = true, silent = true }

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
