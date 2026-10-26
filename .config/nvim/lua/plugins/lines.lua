return {
  { "lukas-reineke/virt-column.nvim", opts = {}, version = "*" },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      disabled_filetypes = { "netrw", "NvimTree", "Lazy", "mason", "help", "text", "markdown", "tex", "html" },
      scope = "window",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "dracula",
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = "",
      },
      sections = { lualine_c = {} },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    -- Styled like the sway tabs: active buffer on #44475a with purple text
    opts = {
      options = {
        indicator = { style = "icon", icon = "▎" },
        separator_style = { "", "" },
      },
      highlights = function(config)
        local hl = {}
        for name in pairs(config.highlights) do
          hl[name] = name:match("_selected$") and { bg = "#44475a" } or { bg = "NONE" }
        end
        return hl
      end,
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "dracula",
      show_dirname = false,
      show_basename = false,
    },
  },
}
