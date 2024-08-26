-- return {
--   "lmburns/lf.nvim",
--   config = function()
--     -- This feature will not work if the plugin is lazy-loaded
--     vim.g.lf_netrw = 1
--
--     require("lf").setup({
--       escape_quit = false,
--       border = "rounded",
--       -- height = 1,
--       -- width = 1,
--       -- height = vim.fn.float2nr(fn.round(0.75 * o.lines)), -- height of the *floating* window
--       -- width = vim.fn.float2nr(fn.round(0.75 * o.columns)), -- width of the *floating* window+k
--     })
--
--     vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
--
--     vim.api.nvim_create_autocmd("User", {
--       -- event = "User",
--       pattern = "LfTermEnter",
--       callback = function(a)
--         vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", { nowait = true })
--       end,
--     })
--   end,
--   dependencies = { "toggleterm.nvim" },
-- }

return {
  "ptzz/lf.vim",
}
