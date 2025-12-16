return {
  -- Configurar registros personalizados de Mason
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "roslyn",
      },
    },
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
