-- Generated by Home Manager.
-- See https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("FiraCode Nerd Font")

-- To work with hyprland
config.enable_wayland = false

-- Theming
config.color_scheme = "Kanagawa (Gogh)"
config.window_background_opacity = 0.8
config.window_padding = {
	left = 1,
	right = 1,
	top = 3,
	bottom = 2,
}
-- keys
local act = wezterm.action
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}
local vim_to_wez_mapper = {
	h = "h",
	j = "j",
	k = "k",
	l = "l",
	Left = "LeftArrow",
	Down = "DownArrow",
	Up = "UpArrow",
	Right = "RightArrow",
}
local wez_to_vim_mapper = {
	h = "h",
	j = "j",
	k = "k",
	l = "l",
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
}
local function split_nav(move_or_resize, key)
	return {
		key = vim_to_wez_mapper[key],
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = wez_to_vim_mapper[key], mods = move_or_resize == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if direction_keys[key] == nil then
					win:perform_action({ AdjustPaneSize = { key, 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

config.keys = {
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "Left"),
	split_nav("resize", "Down"),
	split_nav("resize", "Up"),
	split_nav("resize", "Right"),
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "m",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
}

return config