-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- 默认的shell，注意这里应该是用户级的fish，不是系统级的。配置文件配置的是用户级的，所以这里也是用户级的shell
config.default_prog = { "/usr/bin/fish" }

-- 光标
-- 设置光标为条状
config.default_cursor_style = "BlinkingBar"
-- 设置光标缓入和缓出效果
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
--设置光标闪烁速度
config.cursor_blink_rate = 500

config.color_scheme = "Tokyo Night"

-- 字体
config.font = wezterm.font_with_fallback({
	"EnvyCodeR Nerd Font",
	"CaskaydiaCove Nerd Font Mono",
	"华文仿宋",
})

--字体大小
config.font_size = 15

--透明度
config.window_background_opacity = 0.96

-- 标签栏(外部)
config.window_frame = {
	-- 标签栏字体
	font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Bold", italic = true }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 12.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#1a1b27",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#1a1b27",
}

-- 标签栏（内部）
config.colors = {
	tab_bar = {
		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#3b475e",
			-- The color of the text for the tab
			fg_color = "#c0c0c0",
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#1c2027",
			fg_color = "#808080",
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#1a1b27",
			fg_color = "#808080",
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#1a1b27",
			fg_color = "#ffffff",
			italic = true,
		},
	},
}

-- 初始化大小
config.initial_cols = 60
config.initial_rows = 30

-- 内边距
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- 允许拖动边框调整
config.window_decorations = "NONE"

-- enable ime
config.use_ime = true
config.xim_im_name = "fcitx"

-- and finally, return the configuration to wezterm
return config
