-- Proxy configuration must be set before lazy.nvim runs (required for Treesitter and Blink downloads)
if require("config.meta").is_meta then
  vim.fn.setenv("HTTP_PROXY", "http://fwdproxy:8080")
  vim.fn.setenv("HTTPS_PROXY", "http://fwdproxy:8080")
  vim.fn.setenv("http_proxy", "http://fwdproxy:8080")
  vim.fn.setenv("https_proxy", "http://fwdproxy:8080")
end

require("config.options")
require("config.autocmds")
require("config.utils")
require("config.lazy")

-- Diagnostic configuration (always loaded)
require("config.diagnostics")

if require("config.meta").is_meta then
  -- Metamate AI completion
  require("meta.metamate").init({
    completionKeymap = "<CR>",
    virtualTextHighlightGroup = "ErrorMsg",
    filetypes = { "BUCK", "TARGETS", "python", "cpp", "h", "sh" },
  })

  -- Meta commands and filetypes
  require("meta.cmds")
  require("plenary.filetype").add_file("meta")

  -- Telescope Meta extensions
  require("telescope").load_extension("myles")
  require("telescope").load_extension("biggrep")
  require("telescope").load_extension("hg")

  -- Meta LSP configurations
  require("config.lsp").setup()

  -- Enable wasabi for auto-import code actions
  vim.lsp.enable("wasabi@meta")

  -- Mercurial signs
  require("meta.hg").setup({
    signs = {
      add = { char = "+", hl = "DiffAdd" },
      delete = { char = "_", hl = "DiffDelete" },
    },
    line_blame = {
      enable = false,
      highlight = "Comment",
      prefix = string.rep(" ", 4),
    },
  })
end
