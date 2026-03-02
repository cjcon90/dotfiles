local is_meta = require("config.meta").is_meta

if is_meta then
  return {
    {
      "saghen/blink.cmp",
      dependencies = { "meta.nvim" },
      version = "1.*",
      opts = {
        fuzzy = {
          prebuilt_binaries = {
            extra_curl_args = { "--proxy", "http://fwdproxy:8080" },
          },
        },
        sources = {
          default = { "meta_title", "meta_tags", "meta_tasks", "meta_revsub" },
          providers = {
            meta_title = { name = "MetaTitle", module = "meta.cmp.title" },
            meta_tags = { name = "MetaTags", module = "meta.cmp.tags" },
            meta_tasks = { name = "MetaTasks", module = "meta.cmp.tasks" },
            meta_revsub = { name = "MetaRevSub", module = "meta.cmp.revsub" },
          },
        },
      },
      opts_extend = { "sources.default" },
    },
  }
else
  return {
    {
      "saghen/blink.cmp",
      version = "1.*",
      opts = {},
      opts_extend = { "sources.default" },
    },
  }
end
