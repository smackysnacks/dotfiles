return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = (function()
          local day = os.date("%A %Y/%m/%d")
          assert(type(day) == "string")

          local formatted_day = string.upper(day)
          return string.format(
            [[
%s

]],
            formatted_day
          )
        end)(),
      },
    },
  },
}
