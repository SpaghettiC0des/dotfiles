-- UI Performance Optimizations for nvim-v2
-- This file contains optimizations for UI plugins to improve Neovim performance
-- Applied to the LazyVim-based nvim-v2 configuration

if true then
  return {}
end

return {
  -- Optimize lualine.nvim for better performance
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Performance optimizations for lualine
      opts.options = opts.options or {}

      -- Increase refresh timeout to reduce CPU usage
      opts.options.refresh = {
        statusline = 250, -- Default is 100ms, increase to 250ms
        tabline = 250, -- Default is 100ms, increase to 250ms
        winbar = 250, -- Default is 100ms, increase to 250ms
      }

      -- Disable global status (can be performance heavy)
      opts.options.globalstatus = false

      -- Simplified sections to reduce computation
      opts.sections = {
        -- Left side - keep essential info only
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            -- Limit diff calculations to reduce lag
            symbols = { added = "+", modified = "~", removed = "-" },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- Show relative path only
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
        },

        -- Right side - minimal but useful info
        lualine_x = {
          {
            "diagnostics",
            -- Reduce diagnostic update frequency
            sources = { "nvim_lsp" },
            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
          },
        },
        lualine_y = { "filetype" },
        lualine_z = {
          -- Remove expensive location info, just show line count
          function()
            return vim.fn.line("$") .. "L"
          end,
        },
      }

      -- Disable inactive sections (less computation)
      opts.inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }

      -- Remove expensive extensions
      opts.extensions = nil

      return opts
    end,
  },

  -- Completely disable indent-blankline as it's known to cause performance issues
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  -- Disable or minimize noice.nvim functionality to reduce bugs and performance impact
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts = opts or {}

      -- Disable most noice features that can cause performance issues
      opts.lsp = {
        -- Disable expensive LSP features
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
          ["cmp.entry.get_documentation"] = false,
        },
        hover = {
          enabled = false, -- Disable hover overrides
        },
        signature = {
          enabled = false, -- Disable signature help overrides
        },
        message = {
          enabled = false, -- Disable LSP message overrides
        },
        progress = {
          enabled = false, -- Disable LSP progress notifications
        },
      }

      -- Enable command line with minimal enhancements for functionality
      opts.cmdline = {
        enabled = true, -- Enable command line (essential for : commands)
        view = "cmdline", -- Use standard command line view for better performance
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        },
      }

      -- Disable popupmenu enhancements
      opts.popupmenu = {
        enabled = false,
      }

      -- Keep only essential notification features
      opts.messages = {
        enabled = true, -- Keep basic message handling
        view = "mini", -- Use minimal view
      }

      -- Disable expensive features
      opts.notify = {
        enabled = false, -- Disable notification enhancements
      }

      -- Minimal routes configuration
      opts.routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        -- Suppress LSP "No information available" notifications
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      }

      return opts
    end,
  },

  -- Optimize bufferline for better performance
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}

      -- Reduce animation and visual effects
      opts.options.animation = false
      opts.options.show_buffer_icons = false -- Reduce icon rendering
      opts.options.show_buffer_close_icons = false
      opts.options.show_close_icon = false

      -- Limit buffer display to reduce computation
      opts.options.max_name_length = 18
      opts.options.max_prefix_length = 15
      opts.options.tab_size = 18

      -- Disable expensive sorting
      opts.options.sort_by = nil

      return opts
    end,
  },

  -- Disable nvim-notify animations and reduce functionality
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts = opts or {}
      opts.stages = "static" -- Remove animations
      opts.timeout = 2000 -- Shorter notification duration
      opts.max_height = 5 -- Limit notification size
      opts.max_width = 50
      opts.render = "minimal" -- Use minimal rendering
      return opts
    end,
  },

  -- Optimize which-key for performance
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.triggers_nowait = {} -- Disable instant triggers
      opts.delay = 500 -- Increase delay to reduce frequent calculations
      return opts
    end,
  },

  -- Disable gitsigns on large files for performance
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.max_file_length = 10000 -- Don't attach to files longer than 10k lines
      opts.update_debounce = 200 -- Increase debounce time
      return opts
    end,
  },

  -- Optimize mini.icons for performance
  {
    "echasnovski/mini.icons",
    opts = function(_, opts)
      opts = opts or {}
      opts.style = "glyph" -- Use simpler glyphs
      return opts
    end,
  },
}
