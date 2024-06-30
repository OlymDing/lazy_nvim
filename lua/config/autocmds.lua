-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- Disable autoformat
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.b.autoformat = false
  end,
})

-- disable F1 and v
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<F1>', '<Nop>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'v', 'v', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'V', 'V', { noremap = true, silent = true })
  end
})
