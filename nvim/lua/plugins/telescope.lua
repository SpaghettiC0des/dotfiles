return {

  -- {
  --   "HendrikPetertje/telescope-media-files.nvim",
  --   branch = "fix-replace-ueber-with-viu",
  --   dependencies = {
  --     "nvim-lua/popup.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        event = "VeryLazy",
        config = function(_, _)
          require("lazyvim.util").on_load("telescope.nvim", function()
            require("telescope").load_extension("live_grep_args")
          end)
        end,
        keys = {
          { "<leader>/", ":Telescope live_grep_args<CR>", desc = "Live Grep Args" },
        },
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = vim.fn.executable("make") == 1 and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            local t = require("telescope")
            t.load_extension("fzf")

            t.load_extension("flutter")
            -- t.load_extension("media_files")
            t.load_extension("package_info")
            t.setup({
              pickers = { find_files = { hidden = true } },
              -- find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
              extensions = {
                package_info = {
                  -- Optional theme (the extension doesn't set a default theme)
                  theme = "ivy",
                },
              },
            })
            -- require("telescope").load_extension("live_grep_args")
          end)
        end,
      },
    },
    keys = {
      {
        "<leader>/",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Grep (root dir)",
      },
      {
        "<leader>fl",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    config = function(_, opts)
      local t = require("telescope")
      t.setup(opts)
      t.load_extension("live_grep_args")
    end,
  },
}
