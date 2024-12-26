-- ~/.wezterm.lua
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- shell in windows terminal
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"

-- font
config.font_size = 13
config.font = wezterm.font_with_fallback({
	"EnvyCodeR Nerd Font",
	"CaskaydiaCove Nerd Font Mono",
	"华文仿宋",
})

-- transparency
config.window_background_opacity = 0.96

-- tab
config.window_frame = {
	font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Bold", italic = true }),
	active_titlebar_bg = "#1a1b27",
	inactive_titlebar_bg = "#1a1b27",
}

config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#3b475e",
			fg_color = "#c0c0c0",
		},

		inactive_tab = {
			bg_color = "#1c2027",
			fg_color = "#808080",
		},

		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,
		},

		new_tab = {
			bg_color = "#1a1b27",
			fg_color = "#808080",
		},

		new_tab_hover = {
			bg_color = "#1a1b27",
			fg_color = "#ffffff",
			italic = true,
		},
	},
}

-- paddings
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
