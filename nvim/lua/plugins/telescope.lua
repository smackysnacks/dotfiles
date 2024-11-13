return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      find_files = {
        cmd = vim.fn.getcwd(),
      },
    },
  },
}
