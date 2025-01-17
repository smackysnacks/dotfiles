-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("rust_disable_single_quote_pairs"),

  pattern = "rust",
  callback = function()
    vim.keymap.set("i", "'", "'", { buffer = true })
  end,
})
