return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = true,
      cwd_target = {
        sidebar = "global",
        current = "global",
      },
    },
    window = {
      mappings = {
        ["<C-x>"] = "open_split",
        ["<C-v>"] = "open_vsplit",
      },
    },
  },
}
