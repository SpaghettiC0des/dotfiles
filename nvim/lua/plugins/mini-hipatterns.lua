local MiniHipatterns = require("mini.hipatterns")
local M = require("utils.utils")

local function printWithTag(tag)
  return function(message)
    print(string.format("[%s] %s", tag, message))
  end
end

return {
  "echasnovski/mini.hipatterns",
  opts = {
    highlighters = {
      -- hsl_color = {
      --   -- Match HSL values in the CSS variables (e.g., '222.2 84% 4.9%')
      --   pattern = "hsl%((%d+%.?%d*),%s*(%d+)%%,%s*(%d+)%%%)",
      --   group = function(_, match)
      --     print("Matched CSS HSL:", match)
      --
      --     -- Properly extract h, s, l using the new pattern
      --     local h, s, l = match:match("hsl%((%d+%.?%d*),%s*(%d+)%%,%s*(%d+)%%%)")
      --
      --     -- Convert to numbers
      --     h, s, l = tonumber(h), tonumber(s), tonumber(l)
      --
      --     -- Guard clause for invalid matches
      --     if not (h and s and l) then
      --       print("Invalid HSL match, returning nil")
      --       return nil
      --     end
      --
      --     local hex_color = M.hslToHex(h, s, l)
      --     print("Hex Color Computed:", hex_color)
      --
      --     -- Safely compute the color group
      --     local success, group = pcall(function()
      --       return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
      --     end)
      --
      --     if not success then
      --       print("Error in compute_hex_color_group:", group)
      --       return "ErrorMsg" -- Fallback to a safe highlight group
      --     end
      --
      --     return group
      --   end,
      -- },
      -- css_hsl_color2 = {
      --   -- Match HSL values in the CSS variables (e.g., '222.2 84% 4.9%')
      --   pattern = "%d+ %d+%% %d+%%",
      --   group = function(_, match)
      --     -- print("Matched CSS HSL:", match)
      --
      --     -- Capture hue, saturation, and lightness as strings
      --     local h, s, l = match:match("%d+ %d+%% %d+%%")
      --
      --     -- print("Found matching hsl:", h, s, l)
      --
      --     -- Convert to numbers
      --     h, s, l = tonumber(h), tonumber(s), tonumber(l)
      --
      --     -- Guard clause for invalid matches
      --     if not (h and s and l) then
      --       print("Invalid HSL match, returning nil")
      --       return nil
      --     end
      --
      --     local hex_color = M.hslToHex(h, s, l)
      --     -- print("Hex Color Computed:", hex_color)
      --
      --     -- Safely compute the color group
      --     local success, group = pcall(function()
      --       return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
      --     end)
      --
      --     if not success then
      --       print("Error in compute_hex_color_group:", group)
      --       return "ErrorMsg" -- Fallback to a safe highlight group
      --     end
      --
      --     return group
      --   end,
      -- },
      css_hsl_color_floating_point = {
        pattern = "(%d+%.?%d*)%s+(%d+%.?%d*)%%%s+(%d+%.?%d*)%%",
        group = function(_, match)
          print("Matched CSS HSL:", match)

          -- Capture hue, saturation, and lightness as strings
          local h, s, l = match:gmatch("(%d+%.?%d*)%s*(%d+%.?%d*)%%%s*(%d+%.?%d*)%%")
          -- print("Found matching hsl:", h, s, l)

          -- Convert to numbers
          h, s, l = tonumber(h), tonumber(s), tonumber(l)

          -- Guard clause for invalid matches
          if not (h and s and l) then
            print("Invalid HSL match, returning nil")
            return nil
          end

          local hex_color = M.hslToHex(h, s, l)
          -- print("Hex Color Computed:", hex_color)

          -- Safely compute the color group
          local success, group = pcall(function()
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end)

          if not success then
            print("Error in compute_hex_color_group:", group)
            return "ErrorMsg" -- Fallback to a safe highlight group
          end

          return group
        end,
      },
      css_hsl_color = {
        -- Match HSL values in the CSS variables (e.g., '222.2 84% 4.9%')
        pattern = "%d+ %d+%% %d+%%",
        group = function(_, match)
          -- print("Matched CSS HSL:", match)

          -- Capture hue, saturation, and lightness as strings
          local h, s, l = match:match("(%d+) (%d+)%% (%d+)%%")

          -- print("Found matching hsl:", h, s, l)

          -- Convert to numbers
          h, s, l = tonumber(h), tonumber(s), tonumber(l)

          -- Guard clause for invalid matches
          if not (h and s and l) then
            print("Invalid HSL match, returning nil")
            return nil
          end

          local hex_color = M.hslToHex(h, s, l)
          -- print("Hex Color Computed:", hex_color)

          -- Safely compute the color group
          local success, group = pcall(function()
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end)

          if not success then
            print("Error in compute_hex_color_group:", group)
            return "ErrorMsg" -- Fallback to a safe highlight group
          end

          return group
        end,
      },
    },
  },
}
