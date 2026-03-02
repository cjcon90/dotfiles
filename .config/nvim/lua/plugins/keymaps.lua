local is_meta = require("config.meta").is_meta

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.add({
        {
          mode = { "n", "v" },
          -- Basic commands
          { "<leader>e", "<cmd>Oil<cr>", desc = "Explorer" },
          { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
          { "<leader>q", "<cmd>q!<CR>", desc = "Quit" },
          { "<leader>c", "<cmd>bwipeout<cr>", desc = "Close Buffer" },
          { "<leader>v", "<cmd>vsplit<cr>", desc = "Vertical Split" },
          { "<leader>y", '"+y', desc = "Yank to clipboard", mode = "v" },

          -- Find / Grep (Meta: Biggrep, otherwise: Telescope)
          {
            "<leader>f",
            is_meta and "<cmd>Bgf<cr>" or "<cmd>Telescope find_files<cr>",
            desc = "Find files",
          },
          {
            "<leader>r",
            is_meta and "<cmd>Bgs<cr>" or "<cmd>Telescope live_grep<cr>",
            desc = "Find Text",
          },

          -- Markdown
          { "<leader>m", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Preview" },

          -- Git group
          { "<leader>g", group = "Git" },
          { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
          { "<leader>gj", "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next Hunk" },
          { "<leader>gk", "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Prev Hunk" },
          { "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame" },
          { "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Hunk" },
          { "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Hunk" },
          { "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset Buffer" },
          { "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Hunk" },
          { "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
          { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
          { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
          { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
          { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },

          -- LSP group
          { "<leader>l", group = "LSP" },
          { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
          { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
          { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
          {
            "<leader>lf",
            is_meta and "<cmd>silent !arc f<cr>" or "<cmd>lua vim.lsp.buf.format{async=true}<cr>",
            desc = "Format",
          },
          { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
          { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason" },
          { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
          { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
          { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
          { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
          { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
          { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
          { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },

          -- Trouble group (v2 API)
          { "<leader>t", group = "Trouble" },
          { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble Toggle" },
          { "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
          { "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
          { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble loclist" },
          { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble Quickfix" },
          { "<leader>tR", "<cmd>Trouble lsp_references toggle<cr>", desc = "Trouble LSP References" },
        },
      })
    end,
  },
}
