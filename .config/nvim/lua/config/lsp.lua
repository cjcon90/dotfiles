local M = {}

-- Nvim 0.12.0 passes diagnostics in internal format (lnum/col) to code action
-- requests, but wasabi expects LSP wire format (range).
M.code_action = function()
  local params = vim.lsp.util.make_range_params()
  local diags = {}
  for _, d in ipairs(vim.diagnostic.get(0)) do
    if d.user_data and d.user_data.lsp then
      table.insert(diags, d.user_data.lsp)
    end
  end
  params.context = { diagnostics = diags }
  vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result, ctx)
    if err then
      vim.notify("Code action error: " .. err.message, vim.log.levels.ERROR)
      return
    end
    if not result or #result == 0 then
      vim.notify("No code actions available", vim.log.levels.INFO)
      return
    end
    vim.ui.select(result, {
      prompt = "Code actions:",
      format_item = function(action)
        return action.title
      end,
    }, function(action)
      if not action then
        return
      end
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
      if action.command then
        local command = type(action.command) == "table" and action.command or action
        client:exec_cmd(command)
      end
    end)
  end)
end

M.on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<leader>a", M.code_action, opts)
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
