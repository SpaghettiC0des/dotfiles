if true then
  return {}
end
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      enable_diagnostics = true,
      window = {
        position = "right",
      },
    },
  },
}
