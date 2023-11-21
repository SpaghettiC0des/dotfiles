local config = {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fl",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
__/\\\________/\\\__________________________________/\\\\\\______/\\\________/\\\___/\\\\\\\\\\\___/\\\\____________/\\\\_        
 _\/\\\_____/\\\//__________________________________\////\\\_____\/\\\_______\/\\\__\/////\\\///___\/\\\\\\________/\\\\\\_       
  _\/\\\__/\\\//________________________________________\/\\\_____\//\\\______/\\\_______\/\\\______\/\\\//\\\____/\\\//\\\_      
   _\/\\\\\\//\\\_______/\\\\\\\\\______/\\/\\\\\\\______\/\\\______\//\\\____/\\\________\/\\\______\/\\\\///\\\/\\\/_\/\\\_     
    _\/\\\//_\//\\\_____\////////\\\____\/\\\/////\\\_____\/\\\_______\//\\\__/\\\_________\/\\\______\/\\\__\///\\\/___\/\\\_    
     _\/\\\____\//\\\______/\\\\\\\\\\___\/\\\___\///______\/\\\________\//\\\/\\\__________\/\\\______\/\\\____\///_____\/\\\_   
      _\/\\\_____\//\\\____/\\\/////\\\___\/\\\_____________\/\\\_________\//\\\\\___________\/\\\______\/\\\_____________\/\\\_  
       _\/\\\______\//\\\__\//\\\\\\\\/\\__\/\\\___________/\\\\\\\\\_______\//\\\_________/\\\\\\\\\\\__\/\\\_____________\/\\\_ 
        _\///________\///____\////////\//___\///___________\/////////_________\///_________\///////////___\///______________\///__
      ]]
      dashboard.section.header.val = vim.split(logo, "\n")
      return dashboard
    end,
  },
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint" },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      return {
        suggestion = {
          keymap = {
            accept = "<C-a>",
            accept_word = false,
            accept_line = false,
            next = "<C-l>",
            prev = "<C-h>",
            dismiss = "<C-]>",
          },
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "dressing.nvim",
    opts = {
      input = {
        insert_only = false,
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>t"] = {
          name = "+toggleterm",
        },
      },
    },
  },
}

-- require("flutter-tools").setup({}) -- use defaults

return config
