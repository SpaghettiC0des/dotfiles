return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.left = {
        { ft = "copilot-chat", title = "Copilot Chat", size = { width = 50 } },
      }
      opts.right = {
        { title = "Neotest Summary", ft = "neotest-summary" },
      }
      opts.animate = {
        enabled = false,
      }

      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_buf, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.window.position = "right"
      opts.enable_git_status = true
      opts.enable_diagnostics = true
      
      -- Custom help mapping to position help to the right
      opts.window.mappings = opts.window.mappings or {}
      opts.window.mappings["?"] = function(state)
        local main_win = vim.api.nvim_get_current_win()
        local main_config = vim.api.nvim_win_get_config(main_win)
        
        -- Call default help
        require("neo-tree.ui.inputs").show_help(state)
        
        -- Position help window after it opens
        vim.defer_fn(function()
          local help_win = nil
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if win ~= main_win then
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "neo-tree-popup" then
                help_win = win
                break
              end
            end
          end
          
          if help_win then
            local help_height = math.min(40, vim.o.lines - 4)
            local help_width = 60
            local main_width = main_config.width
            
            -- Resize main window
            vim.api.nvim_win_set_config(main_win, {
              relative = main_config.relative,
              width = main_width,
              height = help_height,
              col = math.floor((vim.o.columns - main_width - help_width - 2) / 2),
              row = math.floor((vim.o.lines - help_height) / 2),
              border = main_config.border,
              zindex = 1000,
            })
            
            local updated_main = vim.api.nvim_win_get_config(main_win)
            
            -- Position help to the right
            vim.api.nvim_win_set_config(help_win, {
              relative = "editor",
              width = help_width,
              height = help_height,
              col = updated_main.col + main_width + 2,
              row = updated_main.row,
              border = "rounded",
              zindex = 1001,
            })
          end
        end, 50)
      end

      table.insert(opts.filesystem, {
        find_command = "fd",
        find_args = { "--exclude", ".git", "--exclude", "node_modules" },
      })
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "Trouble", "qf", "Outline", "trouble" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require("bufferline.offset")
      if not Offset.edgy then
        local get = Offset.get
        ---@diagnostic disable-next-line: duplicate-set-field
        Offset.get = function()
          if package.loaded.edgy then
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
              local sb = layout[pos]
              if sb and #sb.wins > 0 then
                local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
                ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
                ret[pos .. "_size"] = sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return get()
        end
        Offset.edgy = true
      end
    end,
  },
}
