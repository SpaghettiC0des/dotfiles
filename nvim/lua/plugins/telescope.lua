return {
  "telescope.nvim",
  dependencies = {
    -- {
    --   "nvim-telescope/telescope-live-grep-args.nvim",
    --   -- This will not install any breaking changes.
    --   -- For major updates, this must be adjusted manually.
    --   version = "^1.0.0",
    -- },
    "nvim-telescope/telescope-fzf-native.nvim",
    build = vim.fn.executable("make") == 1 and "make"
      or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        local t = require("telescope")
        t.load_extension("flutter")
        t.load_extension("fzf")
        t.setup({
          -- pickers = { find_files = { hidden = true } },
          -- find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
          extensions = {
            package_info = {
              -- Optional theme (the extension doesn't set a default theme)
              theme = "ivy",
            },
          },
        })

        t.load_extension("package_info")
        -- require("telescope").load_extension("live_grep_args")
      end)
    end,
  },
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore

    -- {
    --   -- include hidden files
    --   "<leader><leader>", function ()
    --     require("telescope.builtin").find_files({
    --       find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    --       previewer = false
    --     })
    --   end, desc = "Find files"
    -- },
    -- { "<leader>fs", "<Cmd>AddProject<CR>", desc = "Add Project" },
    -- { "<leader>gC", "<Cmd>Telescope git_bcommits<CR>", desc = "buffer commits" },
    { "<leader>cpT", "<Cmd>Telescope package_info<CR>", desc = "Telescope" },
    -- {
    --   "<leader>/",
    --   ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
    --   desc = "Grep Args(Root Dir)",
    -- },
    {
      "<leader>fl",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
  -- change some options
  opts = function()
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.providers.telescope").open_with_trouble(...)
    end
    local open_selected_with_trouble = function(...)
      return require("trouble.providers.telescope").open_selected_with_trouble(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.telescope("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.telescope("find_files", { hidden = true, default_text = line })()
    end

    local opts = {
      defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        get_selection_window = function()
          require("edgy").goto_main()
          return 0
        end,
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        -- get_selection_window = function()
        --   local wins = vim.api.nvim_list_wins()
        --   table.insert(wins, 1, vim.api.nvim_get_current_win())
        --   for _, win in ipairs(wins) do
        --     local buf = vim.api.nvim_win_get_buf(win)
        --     if vim.bo[buf].buftype == "" then
        --       return win
        --     end
        --   end
        --   return 0
        -- end,
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_selected_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    }

    if not LazyVim.has("flash.nvim") then
      return
    end
    local function flash(prompt_bufnr)
      require("flash").jump({
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
          mode = "search",
          exclude = {
            function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
            end,
          },
        },
        action = function(match)
          local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          picker:set_selection(match.pos[1] - 1)
        end,
      })
    end
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      mappings = { n = { s = flash }, i = { ["<c-s>"] = flash } },
    })

    return opts
  end,
}
