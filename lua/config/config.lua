-- neovide
if vim.fn.exists("g:neovide") == 1 then
  print("hello neovide")
  -- vim.api.nvim_set_var("neovide_refresh_rate", 75)
  vim.o.guifont = "CaskaydiaCove Nerd Font:h20"

  -- set F11 full screen
  vim.api.nvim_set_keymap('n', '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
  vim.keymap.set('', '<C-S-v>', '"+p', { noremap = true, silent = true })
  vim.keymap.set('i', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })

  vim.keymap.set({ "n", "v" }, "<C-=>",
    function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
    end)
  vim.keymap.set({ "n", "v" }, "<C-->", function ()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  end)
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

-- require('sg').setup()

require('lspconfig').rust_analyzer.setup({
  on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end
})

require('lspconfig').clangd.setup({
  on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  end
})

require('lspconfig').pyright.setup({
  cmd = { "pyright-langserver", "--stdio" }
})

vim.notify = require("notify")

vim.notify.setup({
  top_down = false,
  fps = 75,
  stages = "slide",
  timeout = 500
})
