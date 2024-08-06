-- neovide
if vim.fn.exists("g:neovide") == 1 then
  print("hello neovide")
  vim.api.nvim_set_var("neovide_refresh_rate", 75)
  vim.o.guifont = "CaskaydiaCove Nerd Font:h30"

  -- zoom
  vim.keymap.set("", "<C-=>",
    function()
      -- find & get current font size
      local _, _, font_size = vim.o.guifont:find(".*:h(%d+)$")
      font_size = tostring(tonumber(font_size) + 1)
      -- update the font size
      vim.o.guifont = string.gsub(vim.o.guifont, "%d+$", font_size)
    end,
    { noremap = true }
  )
  -- dezoom
  vim.keymap.set("", "<C-->",
    function()
      -- find & get current font size
      local _, _, font_size = vim.o.guifont:find(".*:h(%d+)$")
      if tonumber(font_size) > 1 then
        font_size = tostring(tonumber(font_size) - 1)
        -- update the font size
        vim.o.guifont = string.gsub(vim.o.guifont, "%d+$", font_size)
      end
    end,
    { noremap = true }
  )

  -- set F11 full screen
  vim.api.nvim_set_keymap('n', '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').cycle_history_next,
        ["<C-k>"] = require('telescope.actions').cycle_history_prev,
      },
    },
  },
})

require('sg').setup()

require('lspconfig').rust_analyzer.setup({
  on_attach = function(client, bufnr)
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end
})
