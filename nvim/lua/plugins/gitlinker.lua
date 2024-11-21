return {
  "linrongbin16/gitlinker.nvim",
  opts = {
    config = function()
      require("gitlinker").setup()
    end,
  },
  keys = {
    {
      "<leader>gy",
      "<cmd>GitLink<cr>",
      silent = true,
      noremap = true,
      desc = "Copy git permlink to clipboard",
      mode = { "n", "v" },
    },
    {
      "<leader>gY",
      "<cmd>GitLink!<cr>",
      silent = true,
      noremap = true,
      desc = "Open git permlink in browser",
      mode = { "n", "v" },
    },
    {
      "<leader>gb",
      "<cmd>GitLink blame<cr>",
      silent = true,
      noremap = true,
      desc = "Copy git blame link to clipboard",
      mode = { "n", "v" },
    },
    {
      "<leader>gB",
      "<cmd>GitLink! blame<cr>",
      silent = true,
      noremap = true,
      desc = "Open git blame link in browser",
      mode = { "n", "v" },
    },
  },
}
