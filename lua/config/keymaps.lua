-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.Ex)

-- move as a block up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep the cursor right in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- remap all current word !
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>bs", function()
  if not vim.o.scrollbind then
    print("bind scroll")
  else
    print("unset bind scroll")
  end
  vim.o.scrollbind = not vim.o.scrollbind
end)

-- remove lazyvim default keymap
vim.keymap.del("n", "f")
vim.keymap.del("n", "s")
vim.keymap.del("n", "<leader>wm")
vim.keymap.del("n", "<leader>wd")
vim.keymap.del("n", "<leader>w|")
vim.keymap.del("n", "<leader>ww")
vim.keymap.del("n", "<leader>w-")
vim.keymap.del("t", "<C-l>")

-- cmp
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
  }),
  experimental = {
    ghost_text = false,
  },
})

-- transparent toggle
vim.keymap.set("n", "<leader>tt", function()
  print("toggle transparent")
  vim.cmd.TransparentToggle()
end)

-- dark/light toggle
vim.keymap.set("n", "<F8>", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    vim.cmd.TransparentEnable()
  else
    vim.o.background = "light"
    vim.cmd.TransparentDisable()
  end
end)

-- barbar
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>")
vim.keymap.set("n", "<A-w>", "<Cmd>BufferClose<CR>")

-- harpoon
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", harpoon_mark.add_file)
vim.keymap.set("n", "<leader>e", harpoon_ui.toggle_quick_menu)

vim.keymap.set("n", "<F1>", function()
  harpoon_ui.nav_file(1)
end)
vim.keymap.set("n", "<F2>", function()
  harpoon_ui.nav_file(2)
end)
vim.keymap.set("n", "<F3>", function()
  harpoon_ui.nav_file(3)
end)
vim.keymap.set("n", "<F4>", function()
  harpoon_ui.nav_file(4)
end)

-- lsp
vim.keymap.set("n", "<F6>", function()
  vim.lsp.buf.rename()
end)
vim.keymap.set("n", "<F7>", function()
  vim.lsp.buf.format()
end)

require('nvim_comment').setup({
  comment_empty = false,
  line_mapping = "<C-\\>",
  operator_mapping = "\\",
})

require("toggleterm").setup {
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<F9>]],
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
  direction = "vertical"
}

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Actions
    map('n', '<F10>', gs.preview_hunk)
    map('n', '<F12>', gs.diffthis)

    -- map('n', '<leader>hd', gs.diffthis)
    -- map('n', '<leader>hD', function() gs.diffthis('~') end)
  end
}
