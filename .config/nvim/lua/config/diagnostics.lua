-- Apply diagnostic config after LazyVim loads (VeryLazy) to avoid being overridden
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        source = "if_many",
        format = function(diagnostic)
          return diagnostic.message
        end,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      underline = { enabled = true },
      update_in_insert = false,
      severity_sort = true,
      float = {
        enabled = true,
        source = "if_many",
        border = "rounded",
        focusable = true,
        header = "",
        prefix = "",
      },
    })
  end,
})
