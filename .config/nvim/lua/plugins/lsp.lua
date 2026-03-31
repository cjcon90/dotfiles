return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "stylua", "shfmt", "prettier", "ruff", "taplo",
        "goimports", "gofumpt", "hadolint",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright       = {},
        ruff          = {},
        gopls         = {},
        rust_analyzer = {},
        bashls        = {},
        lua_ls        = {},
        ts_ls         = {},
        cssls         = {},
        html          = {},
        jsonls        = {},
        yamlls        = {},
        dockerls      = {},
        taplo         = {},
        sqlls         = {},
      },
      diagnostics = {
        virtual_text = {
          format = function(diagnostic)
            local new_line_location = diagnostic.message:find("\n")
            if new_line_location ~= nil then
              return diagnostic.message:sub(1, new_line_location)
            else
              return diagnostic.message
            end
          end,
        },
      },
      format = { timeout_ms = 2500 },
    },
  },
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    keys = {
      { "<leader>o", "<cmd>AerialToggle<cr>", desc = "Code Outline" },
    },
    opts = {
      backends = { "lsp", "treesitter" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
}
