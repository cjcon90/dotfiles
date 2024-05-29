local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    -- Set the height of the bufferline
    height = 2,
    -- Set the maximum number of buffers to show
    max_name_length = 18,
    -- Set the maximum number of tab pages to show
    max_prefix_length = 15,
    -- Set the maximum number of tabs to show
    tab_size = 18,
    -- Set the padding of the bufferline
    padding = 1,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    -- Set the colors of the bufferline
    colors = {
      background = '#282a36',
      inactive_bg = '#282a36',
      active_bg = '#44475a',
      inactive_fg = '#6272a4',
      active_fg = '#f8f8f2',
      -- Set the color of the separator between the buffers
      separator = '#44475a',
      -- Set the color of the modified buffer indicator
      modified = '#ff79c6',
      -- Set the color of the close button
      close = '#ff5555',
      -- Set the color of the close button when hovered over
      close_hover = '#ff8888'
    },
    -- Set the icons for the bufferline
    icons = {
      -- Set the icon for the modified buffer indicator
      modified = '●',
      -- Set the icon for the close button
      close = '',
      -- Set the icon for the close button when hovered over
      close_hover = ''
    }
  }
})
