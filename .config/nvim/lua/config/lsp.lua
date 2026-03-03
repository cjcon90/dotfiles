local M = {}

M.on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Meta-specific LSP keymaps (supplement LazyVim defaults)
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
end

M.setup = function()
  if not require("config.meta").is_meta then
    return
  end

  require("meta.lsp")

  local servers = {
    "rust-analyzer@meta",
    "fb-pyright-ls@meta",
    "pyre@meta",
    "pyre-codenav@meta",
    "wasabi@meta",
    "thriftlsp@meta",
    "cppls@meta",
    "buckls@meta",
    "buck2@meta",
    "erlang@meta",
    "gopls@meta",
    "eslint@meta",
    "prettier@meta",
    "flow@meta",
    "hhvm",
    "linttool@meta",
    "relay@meta",
    "kotlin@meta",
  }

  local servers_with_init_options = {
    ["fb-pyright-ls@meta"] = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = false,
      closingLabels = true,
    },
    ["flow@meta"] = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = false,
      closingLabels = true,
    },
  }

  for _, lsp in ipairs(servers) do
    local config_update = { on_attach = M.on_attach }
    if servers_with_init_options[lsp] then
      config_update.init_options = servers_with_init_options[lsp]
    end
    vim.lsp.config(lsp, config_update)
  end

  vim.lsp.enable(servers)

  local null_ls = require("null-ls")
  local meta = require("meta")
  null_ls.setup({
    on_attach = M.on_attach,
    sources = {
      meta.null_ls.diagnostics.arclint,
      meta.null_ls.formatting.arclint,
    },
  })
end

return M
