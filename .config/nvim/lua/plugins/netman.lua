return {
  "miversen33/netman.nvim",
  branch = "174-fix-failure-to-clean-fail",
  cmd = { "NmloadProvider", "Nmlogs", "Nmdelete", "Nmread", "Nmwrite" },
  config = function()
    require("netman")
  end,
  enabled = false,
}
