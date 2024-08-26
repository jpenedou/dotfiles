-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- Se cambia Shift por Alt para cambiar de buffer
if not vim.g.vscode then
  vim.keymap.set("n", "<A-h>", "<cmd>bprevious<cr>")
  vim.keymap.set("n", "<A-l>", "<cmd>bnext<cr>")
end

-- Con enter se desplaza la línea hacia abajo en modo normal
-- vim.keymap.set("n", "<CR>", "O<ESC>j")

-- Visual Studio Code actions
if vim.g.vscode then
  -- vim.keymap.set("n", "<space>", "i<space><Esc>")

  vim.keymap.set("n", "gD", "<cmd>lua require('vscode-neovim').call('editor.action.peekDefinition')<CR>")
  vim.keymap.set("n", "gd", "<cmd>lua require('vscode-neovim').call('editor.action.revealDefinition')<CR>")
  vim.keymap.set("n", "gr", "<cmd>lua require('vscode-neovim').call('editor.action.referenceSearch.trigger')<CR>")
  vim.keymap.set("n", "gR", "<cmd>lua require('vscode-neovim').call('references-view.findReferences')<CR>")
  vim.keymap.set("n", "gy", "<cmd>lua require('vscode-neovim').call('editor.action.goToTypeDefinition')<CR>")
  vim.keymap.set("n", "gI", "<cmd>lua require('vscode-neovim').call('editor.action.goToImplementation')<CR>")
  vim.keymap.set("n", "grn", "<cmd>lua require('vscode-neovim').call('editor.action.rename')<CR>")
end

vim.keymap.set("n", "<C-Z>", "<C-]>")
