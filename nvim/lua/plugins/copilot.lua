return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    cmd = "CopilotChat",
    opts = {
      model = "claude-3.7-sonnet",
      mappings = {
        reset = { normal = "<C-r>", insert = "<C-r>" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
        end,
      })

      chat.setup(opts)
    end,
  },
}
