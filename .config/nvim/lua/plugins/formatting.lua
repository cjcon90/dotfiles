return {
  "stevearc/conform.nvim",
  opts = {
    -- Format on save for Go (replaces the manual BufWritePre gofmt autocmd)
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == "go" then
        return { timeout_ms = 2500, lsp_format = "fallback" }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      go = { "goimports", "gofmt" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      toml = { "taplo" },
    },
  },
}
