return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec = {
        -- Basic commands
        { "<leader>w", "<cmd>w<cr>", desc = "Save" },
        { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
        { "<leader>c", "<cmd>bwipeout<cr>", desc = "Close Buffer" },

        -- Telescope
        -- { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        -- { "<leader>r", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },

        -- Window management
        { "<leader>v", "<cmd>vsplit<cr>", desc = "Vertical Split" },
        { "<leader>y", "<cmd>OSCYankVisual<cr>", desc = "Yank selection to clipboard", mode = "v" },
        -- { "<leader>T", "<cmd>FTermOpen<cr>", desc = "Open Terminal" },

        -- LSP (subgroup)
        {
          "<leader>l",
          group = "LSP",
          {
            "<leader>la",
            "<cmd>lua vim.lsp.buf.code_action()<cr>",
            desc = "Code Action",
          },
          {
            "<leader>ld",
            "<cmd>Telescope diagnostics bufnr=0<cr>",
            desc = "Document Diagnostics",
          },
          {
            "<leader>lw",
            "<cmd>Telescope diagnostics<cr>",
            desc = "Workspace Diagnostics",
          },
          {
            "<leader>lf",
            "<cmd>lua vim.lsp.buf.format{async=true}<cr>",
            desc = "Format",
          },
          { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
          { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
          {
            "<leader>lj",
            "<cmd>lua vim.diagnostic.goto_next()<cr>",
            desc = "Next Diagnostic",
          },
          {
            "<leader>lk",
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            desc = "Prev Diagnostic",
          },
          {
            "<leader>ll",
            "<cmd>lua vim.lsp.codelens.run()<cr>",
            desc = "CodeLens Action",
          },
          {
            "<leader>lq",
            "<cmd>lua vim.diagnostic.setloclist()<cr>",
            desc = "Quickfix",
          },
          {
            "<leader>lr",
            "<cmd>lua vim.lsp.buf.rename()<cr>",
            desc = "Rename",
          },
          {
            "<leader>ls",
            "<cmd>Telescope lsp_document_symbols<cr>",
            desc = "Document Symbols",
          },
          {
            "<leader>lS",
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            desc = "Workspace Symbols",
          },
        },
        -- Markdown
        {
          {
            "<leader>m",
            "<cmd>RenderMarkdown preview<cr>",
            desc = "Toggle Markdown Preview",
          },
        },
        -- Trouble (subgroup)
        {
          "<leader>t",
          group = "Trouble",
          {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Trouble Toggle",
          },
          {
            "<leader>tw",
            "<cmd>Trouble workspace_diagnostics toggle<cr>",
            desc = "Workspace Diagnostics",
          },
          {
            "<leader>td",
            "<cmd>Trouble document_diagnostics toggle<cr>",
            desc = "Document Diagnostics",
          },
          {
            "<leader>tl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Trouble loclist",
          },
          {
            "<leader>tq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Trouble Quickfix",
          },
          {
            "<leader>tR",
            "<cmd>Trouble lsp_references toggle<cr>",
            desc = "Trouble LSP References",
          },
        },
      }
    end,
  },

  -- Additional non-which-key mappings
  {
    "LazyVim/LazyVim",
    opts = function()
      local wk = require("which-key")

      -- Window navigation
      vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

      -- Window resize
      vim.keymap.set("n", "<C-Up>", ":resize +2<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-Down>", ":resize -2<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-Left>", ":vertical resize -2<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<C-Right>", ":vertical resize +2<cr>", { noremap = true, silent = true })

      -- Buffer navigation
      vim.keymap.set("n", "<S-l>", ":bnext<cr>", { noremap = true, silent = true })
      vim.keymap.set("n", "<S-h>", ":bprevious<cr>", { noremap = true, silent = true })

      -- Insert mode escape
      vim.keymap.set("i", ";a", "<Esc>", { noremap = true, silent = true })

      -- Visual mode indent
      vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
      vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

      -- Retain yank after paste in visual
      vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })

      -- Visual block text movement
      vim.keymap.set("x", "J", ":move '>+1<cr>gv-gv", { noremap = true, silent = true })
      vim.keymap.set("x", "K", ":move '<-2<cr>gv-gv", { noremap = true, silent = true })

      -- Terminal navigation
      vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
      vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
      vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
      vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })
    end,
  },
}
