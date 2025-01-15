return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
 ▄▄    ▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ 
█  █  █ █       █       █  █ █  █   █  █▄█  █
█   █▄█ █    ▄▄▄█   ▄   █  █▄█  █   █       █
█       █   █▄▄▄█  █ █  █       █   █       █
█  ▄    █    ▄▄▄█  █▄█  █       █   █       █
█ █ █   █   █▄▄▄█       ██     ██   █ ██▄██ █
█▄█  █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█ █▄▄▄█ █▄▄▄█▄█   █▄█

]],
      },
    },

    picker = {
      win = {
        input = {
          keys = {
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<c-x>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-e>"] = { "toggle_live", mode = { "i", "n" } },
          },
        },
      },
      list = {
        keys = {
          ["<c-v>"] = "edit_vsplit",
          ["<c-x>"] = "edit_split",
        },
      },
    },
  },
}
