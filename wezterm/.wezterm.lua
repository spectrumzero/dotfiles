-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- 启动时最大化
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)

-- 默认的shell，注意这里应该是用户级的fish，不是系统级的。配置文件配置的是用户级的，所以这里也是用户级的shell
config.default_prog = { "/usr/bin/fish" }

-- shell in windows terminal
-- config.default_prog = { "pwsh.exe", "-NoLogo" }

-- 光标
-- 设置光标为条状
config.default_cursor_style = "BlinkingBar"
-- 设置光标缓入和缓出效果
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
--设置光标闪烁速度
config.cursor_blink_rate = 500

-- 可以定义自己的颜色
config.colors = {
	--	-- The default text color
	--	-- 默认文本颜色
	-- foreground = "silver",
	-- The default background color
	--
	-- 默认背景颜色
	-- background = "#282828",
	--	-- 光标前景色(光标下的文本色)
	--	cursor_fg = "#ffffff",
	--	-- 光标背景色（光标色）
	--	cursor_bg = "#ffffff",
	--	cursor_border = "#ffffff",
	--
	--	--用于配置命令、提示符等的颜色
	--	-- 普通颜色
	--	ansi = {
	--		-- 黑色
	--		"black",
	--		-- 红色
	--		"#e06c75",
	--		-- 绿色
	--		"#77995e",
	--		-- 黄色
	--		"#ffffff",
	--		-- 蓝色
	--		"#4f9ea8",
	--		-- 紫色
	--		"purple",
	--		-- 青色
	--		"#4f9fa9",
	--		-- 白色
	--		"silver",
	--	},
	--	-- 明亮颜色
	--	brights = {
	--		-- 黑色
	--		"black",
	--		-- 红色
	--		"#e06c75",
	--		-- 绿色
	--		"#77995e",
	--		-- 黄色
	--		"#ffffff",
	--		-- 蓝色
	--		"#61afef",
	--		-- 紫色
	--		"#a685dd",
	--		-- 青色
	--		"#4f9fa9",
	--		-- 白色
	--		"silver",
	--	},
}

--但还是主要采用颜色主题。一般情况下，scheme的优先级高于color
config.color_scheme = "Tokyo Night"

-- 字体
config.font = wezterm.font_with_fallback({
	"EnvyCodeR Nerd Font",
	"CaskaydiaCove Nerd Font Mono",
	"华文仿宋",
})

--字体大小
config.font_size = 14

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

--全屏切换快捷键(shift+CTRL+n)
config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
}

-- and finally, return the configuration to wezterm
return config
