if true then
  return {}
end

local MiniHipatterns = require("mini.hipatterns")
-- local H = MiniHipatterns
--
-- local M = {}
-- M.rgb_color = function(opts)
--   local default_opts = { style = "full", priority = 200, filter = H.always_true, inline_text = "█" }
--   opts = vim.tbl_deep_extend("force", default_opts, opts or {})
--
--   local style = opts.style
--   if style == "inline" and vim.fn.has("nvim-0.10") == 0 then
--     H.error('Style "inline" in `gen_highlighter.rgb_color()` requires Neovim>=0.10.')
--   end
--
--   local pattern = style == "#" and "()rgb()%((%d+),(%d+),(%d+))%f[%X]" or "rgb%((%d+),(%d+),(%d+))%f[%X]"
--   local hl_style = ({ full = "bg", ["#"] = "bg", line = "line", inline = "fg" })[style] or "bg"
--
--   local extmark_opts = { priority = opts.priority }
--   if opts.style == "inline" then
--     local priority, inline_text = opts.priority, opts.inline_text
--     ---@diagnostic disable:cast-local-type
--     extmark_opts = function(_, _, data)
--       local virt_text = { { inline_text, data.hl_group } }
--       return { virt_text = virt_text, virt_text_pos = "inline", priority = priority, right_gravity = false }
--     end
--   end
--
--   return {
--     pattern = H.wrap_pattern_with_filter(pattern, opts.filter),
--     group = function(_, _, data)
--       return MiniHipatterns.compute_rgb_color_group(data.full_match, hl_style)
--     end,
--     extmark_opts = extmark_opts,
--   }
-- end
--
-- M.rgba_color = function(opts)
--   local default_opts = { style = "full", priority = 200, filter = H.always_true, inline_text = "█" }
--   opts = vim.tbl_deep_extend("force", default_opts, opts or {})
--
--   local style = opts.style
--   if style == "inline" and vim.fn.has("nvim-0.10") == 0 then
--     H.error('Style "inline" in `gen_highlighter.rgba_color()` requires Neovim>=0.10.')
--   end
--
--   local pattern = style == "#" and "()rgba()%((%d+),(%d+),(%d+),(%d+%.?%d*)%)%f[%X]"
--     or "rgba%((%d+),(%d+),(%d+),(%d+%.?%d*)%)%f[%X]"
--   local hl_style = ({ full = "bg", ["#"] = "bg", line = "line", inline = "fg" })[style] or "bg"
--
--   local extmark_opts = { priority = opts.priority }
--   if opts.style == "inline" then
--     local priority, inline_text = opts.priority, opts.inline_text
--     ---@diagnostic disable:cast-local-type
--     extmark_opts = function(_, _, data)
--       local virt_text = { { inline_text, data.hl_group } }
--       return { virt_text = virt_text, virt_text_pos = "inline", priority = priority, right_gravity = false }
--     end
--   end
--
--   return {
--     pattern = H.wrap_pattern_with_filter(pattern, opts.filter),
--     group = function(_, _, data)
--       return MiniHipatterns.compute_rgba_color_group(data.full_match, hl_style)
--     end,
--     extmark_opts = extmark_opts,
--   }
-- end
--
-- local hsl_to_hex = function(h, s, l)
--   -- Actually convert h, s, l numbers into hex color in '#RRGGBB' format
--   return "#ffffff"
-- end
-- -- Returns hex color group for matching hsl() color.
-- --
-- ---@param match string
-- ---@return string
-- local hsl_color = function(_, match)
--   local style = "bg" -- 'fg' or 'bg'
--   local hue, saturation, lightness = match:match("hsl%((%d+), ?(%d+)%%, ?(%d+)%%%)")
--
--   -- Converts HSL to RGB.
--   -- https://www.w3.org/TR/css-color-3/#hsl-color
--   --
--   ---@param h string The hue value in degrees.
--   ---@param s string The saturation value in percent.
--   ---@param l string The lightness value in percent.
--   ---@return integer, integer, integer
--   local function hsl_to_rgb(h, s, l)
--     h, s, l = h % 360, s / 100, l / 100
--     if h < 0 then
--       h = h + 360
--     end
--     local function f(n)
--       local k = (n + h / 30) % 12
--       local a = s * math.min(l, 1 - l)
--       return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
--     end
--     return f(0) * 255, f(8) * 255, f(4) * 255
--   end
--
--   local red, green, blue = hsl_to_rgb(hue, saturation, lightness)
--   local hex = string.format("#%02x%02x%02x", red, green, blue)
--   return MiniHipatterns.compute_hex_color_group(hex, style)
-- end

return {
  "echasnovski/mini.hipatterns",
  enabled = false,
  version = false,
  opts = {},
  config = function(_, opts)
    require("mini.hipatterns").setup(opts)

    local hipatterns = require("mini.hipatterns")

    -- Returns hex color group for matching short hex color.
    --
    ---@param match string
    ---@return string
    local hex_color_short = function(_, match)
      local style = "fg" -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
      local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgb() color.
    --
    ---@param match string
    ---@return string
    local rgb_color = function(_, match)
      local style = "fg" -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local red, green, blue = match:match("rgb%((%d+), ?(%d+), ?(%d+)%)")
      local hex = string.format("#%02x%02x%02x", red, green, blue)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgba() color
    -- or false if alpha is nil or out of range.
    -- The use of the alpha value refers to a black background.
    --
    ---@param match string
    ---@return string|false
    local rgba_color = function(_, match)
      local style = "fg" -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local red, green, blue, alpha = match:match("rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)")
      alpha = tonumber(alpha)
      if alpha == nil or alpha < 0 or alpha > 1 then
        return false
      end
      local hex = string.format("#%02x%02x%02x", red * alpha, green * alpha, blue * alpha)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns extmark opts for highlights with virtual inline text.
    --
    ---@param data table Includes `hl_group`, `full_match` and more.
    ---@return table
    local extmark_opts_inline = function(_, _, data)
      return {
        virt_text = { { " ", data.hl_group } },
        virt_text_pos = "inline",
        -- priority = 200,
        right_gravity = false,
      }
    end

    hipatterns.setup({
      highlighters = {
        -- `#rrggbb`
        -- hex_color = hipatterns.gen_highlighter.hex_color({ style = 'full' }),
        -- hex_color = hipatterns.gen_highlighter.hex_color({ style = "inline", inline_text = " " }),
        -- `#rgb`
        -- hex_color_short = { pattern = "#%x%x%x%f[%X]", group = hex_color_short, extmark_opts = extmark_opts_inline },
        -- `rgb(255, 255, 255)`
        rgb_color = { pattern = "rgb%(%d+, ?%d+, ?%d+%)", group = rgb_color, extmark_opts = extmark_opts_inline },
        -- `rgba(255, 255, 255, 0.5)`
        rgba_color = {
          pattern = "rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)",
          group = rgba_color,
          extmark_opts = extmark_opts_inline,
        },
      },
    })
  end,
}
