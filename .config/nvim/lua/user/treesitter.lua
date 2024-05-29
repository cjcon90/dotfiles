local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx", "css", "rust", "java",
    "yaml", "markdown", "markdown_inline", "go", "rust", "html", "scss" }, -- one of "all" or a list of languages
  ignore_install = {},                                                     -- List of parsers to ignore installing
  highlight = {
    enable = true,                                                         -- false will disable the whole extension
    disable = {},                                                          -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = {} },
})
