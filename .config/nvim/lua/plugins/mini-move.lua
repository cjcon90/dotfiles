return {
  {
    "nvim-mini/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Visual mode: move selection
        left = "<S-Left>",
        right = "<S-Right>",
        down = "J",
        up = "K",
        -- Normal mode: move current line
        line_left = "<S-Left>",
        line_right = "<S-Right>",
        line_down = "<S-Down>",
        line_up = "<S-Up>",
      },
    },
  },
}
