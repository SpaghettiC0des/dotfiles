local session_manager = require("wezterm-session-manager/session-manager")
-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This table will hold the configuration.
local config = {}

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end
wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)
-- This is where you actually apply your config choices

-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 150
config.font_size = 30.0
-- config.font = wezterm.font("Operator Mono Lig")
-- config.font = wezterm.font("BlexMono Nerd Font")
config.font = wezterm.font("Ligalex Mono")
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
-- config.color_scheme = 'Adventure'
-- config.color_scheme = '3024 Night'
-- config.color_scheme = 'Apathy (base16)'
-- config.color_scheme = "Atelier Cave (base16)"
-- config.color_scheme = "Atelier Forest (base16)"
-- config.color_scheme = "Atelier Sulphurpool (base16)"
-- config.color_scheme = "Atelierdune (dark) (terminal.sexy)"
-- config.color_scheme = 'Atom'
-- config.color_scheme = "Ayu Dark (Gogh)"
-- config.color_scheme = 'Ayu Mirage'
-- config.color_scheme = "Night Owl (Gogh)"
-- config.color_scheme = "Neon Night (Gogh)"
-- config.color_scheme = "nightfox"
-- config.color_scheme = 'Purple People Eater (Gogh)'
-- config.color_scheme = "purplepeter"
-- config.color_scheme = "Tokyo Night (Gogh)"
config.launch_menu = {}
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
	{
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	}, -- rotate panes
	{
		mods = "LEADER",
		key = "Space",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	-- This will create a new split and run your default program inside it
	{
		key = "p",
		mods = "LEADER",
		action = act.PaneSelect({
			alphabet = "1234567890",
		}),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A

	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
	{ key = "v", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "s", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
	{ key = "q", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

	{ key = "n", mods = "SHIFT|CTRL", action = "ToggleFullScreen" },
	{ key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "SHIFT|CTRL", action = wezterm.action.CopyTo("Clipboard") },

	{ key = "S", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) },
	{ key = "L", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) },
	{ key = "R", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) },
	-- Add key bindings for moving to next/previous tab
	{ key = "Tab", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "Tab", mods = "LEADER|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = ",", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
}

-- if wezterm.target_triple == "x86_64-pc-windows-msvc" then
-- 	config.front_end = "Software" -- OpenGL doesn't work quite well with RDP.
-- 	config.term = "" -- Set to empty so FZF works on windows
-- 	config.default_prog = { "cmd.exe" }
-- 	table.insert(config.launch_menu, { label = "PowerShell", args = { "powershell.exe", "-NoLogo" } })
--
-- 	-- Find installed visual studio version(s) and add their compilation
-- 	-- environment command prompts to the menu
-- 	for _, vsvers in ipairs(wezterm.glob("Microsoft Visual Studio/20*", "C:/Program Files (x86)")) do
-- 		local year = vsvers:gsub("Microsoft Visual Studio/", "")
-- 		table.insert(config.launch_menu, {
-- 			label = "x64 Native Tools VS " .. year,
-- 			args = {
-- 				"cmd.exe",
-- 				"/k",
-- 				"C:/Program Files (x86)/" .. vsvers .. "/BuildTools/VC/Auxiliary/Build/vcvars64.bat",
-- 			},
-- 		})
-- 	end
-- else
-- 	table.insert(config.launch_menu, { label = "bash", args = { "bash", "-l" } })
-- 	table.insert(config.launch_menu, { label = "fish", args = { "fish", "-l" } })
-- end
-- and finally, return the configuration to wezterm
return config
