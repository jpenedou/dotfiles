return {
  "saghen/blink.cmp",
  dependencies = { "allaman/emoji.nvim", "saghen/blink.compat" },
  opts = {
    keymap = {
      preset = "super-tab",
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<CR>"] = { "accept", "fallback" },
    },
    sources = {
      default = {
        ...,
        "emoji",
      },
      providers = {
        emoji = {
          name = "emoji",
          module = "blink.compat.source",
          -- overwrite kind of suggestion
          transform_items = function(ctx, items)
            local kind = require("blink.cmp.types").CompletionItemKind.Text
            for i = 1, #items do
              items[i].kind = kind
            end
            return items
          end,
        },
      },
    },
  },
}
