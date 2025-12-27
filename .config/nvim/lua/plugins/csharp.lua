return {
  -- Configurar registros personalizados de Mason
  {
    "mason-org/mason.nvim",
    opts = {
      registries = { "github:mason-org/mason-registry", "github:Crashdummyy/mason-registry" },
      ensure_installed = { "roslyn" },
    },
  },
  -- Evitar que Omnisharp sea configurado por lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.setup = opts.setup or {}
      opts.setup["omnisharp"] = function()
        return true
      end
    end,
  },
  -- Configurar Roslyn LSP
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {
      -- Configuración adicional si es necesaria
    },
  },
}
