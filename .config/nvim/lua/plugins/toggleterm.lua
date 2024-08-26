return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<leader>t]],
        shade_terminals = false,
        insert_mappings = false,
        -- shell = "pwsh.exe",
      })
    end,
    version = "*",
    keys = {
      {
        "<leader>t",
        "<cmd>ToggleTerm size=20 direction=horizontal<cr>",
        desc = "Open a horizontal terminal below",
        mode = { "n" },
      },
    },
  },
}
