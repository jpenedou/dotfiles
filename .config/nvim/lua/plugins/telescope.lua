local symbols = require("lazyvim.config").get_kind_filter()

if type(symbols) == "table" then
  table.insert(symbols, "constant")
end

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_document_symbols(symbols)
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols(symbols)
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
}
