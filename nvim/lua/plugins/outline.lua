return {
  "hedyhli/outline.nvim",
  opts = {
    symbols = {
      filter = {
        ---@diagnostic disable-next-line: param-type-mismatch
        rust = vim.list_extend(vim.deepcopy(LazyVim.config.kind_filter["default"]), { "Object" }),
      },
    },
  },
}
