-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.window_background_opacity = 0.5
config.macos_window_background_blur = 30
config.font_size = 20.0
config.font = wezterm.font 'Operator Mono Lig'
-- config.font = wezterm.font 'Ligalex Mono'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Adventure'
-- config.color_scheme = '3024 Night'
-- config.color_scheme = 'Apathy (base16)'
-- config.color_scheme = 'Atelier Cave (base16)'
-- config.color_scheme = 'Atelier Forest (base16)'
-- config.color_scheme = 'Atelier Sulphurpool (base16)'
-- config.color_scheme = 'Atelierdune (dark) (terminal.sexy)'
-- config.color_scheme = 'Atom'
-- config.color_scheme = 'Ayu Dark (Gogh)'
-- config.color_scheme = 'Ayu Mirage'
config.color_scheme = 'Night Owl (Gogh)'
-- config.color_scheme = 'Neon Night (Gogh)'
-- config.color_scheme = 'nightfox'

-- and finally, return the configuration to wezterm
return config
