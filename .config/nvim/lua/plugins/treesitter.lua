return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "cuda",
        "diff", "elixir", "erlang", "fish", "gitattributes", "go", "gomod",
        "graphql", "hack", "haskell", "hcl", "heex", "hjson", "html", "http",
        "java", "javascript", "jsdoc", "json", "json5", "kotlin", "lua",
        "luadoc", "luap", "make", "markdown", "markdown_inline", "ocaml",
        "ocaml_interface", "perl", "php", "python", "query", "regex", "ruby",
        "rust", "sql", "starlark", "thrift", "tlaplus", "toml", "tsx",
        "typescript", "vim", "vimdoc", "xml", "yaml",
      },
      highlight = { enable = true, disable = { "dockerfile" } },
      indent = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      vim.cmd("hi TreesitterContextBottom gui=underdashed guisp=#585b70")
    end,
  },
}
