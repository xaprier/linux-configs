#!/usr/bin/env bash
#  ███████╗██╗██╗    ██╗   ██╗██╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔════╝██║██║    ██║   ██║██║██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ███████╗██║██║    ██║   ██║██║███████║    ██████╔╝██║██║     █████╗
#  ╚════██║██║██║    ╚██╗ ██╔╝██║██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ███████║██║███████╗╚████╔╝ ██║██║  ██║    ██║  ██║██║╚██████╗███████╗
#  ╚══════╝╚═╝╚══════╝ ╚═══╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Silvia
set_bspwm_config() {
	bspc config border_width 0
	bspc config top_padding 52
	bspc config bottom_padding 2
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config normal_border_color "#d3869b"
	bspc config active_border_color "#d3869b"
	bspc config focused_border_color "#fbf1c7"
	bspc config presel_feedback_color "#b8bb26"
}

# Set alacritty colorscheme
set_alacritty_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# (Gruvbox) Color scheme for Silvia Rice

# Default colors
[colors.primary]
background = "#282828"
foreground = "#fbf1c7"

# Cursor colors
[colors.cursor]
cursor = "#fbf1c7"
text = "#282828"

# Normal colors
[colors.normal]
black = "#a89984"
blue = "#458588"
cyan = "#689d6a"
green = "#98971a"
magenta = "#b16286"
red = "#cc241d"
white = "#ebdbb2"
yellow = "#d79921"

# Bright colors
[colors.bright]
black = "#a89984"
blue = "#83a598"
cyan = "#8ec07c"
green = "#b8bb26"
magenta = "#d3869b"
red = "#fb4934"
white = "#ebdbb2"
yellow = "#fabd2f"
EOF
}

# Set kitty colorscheme
set_kitty_config() {
	cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
## This file is autogenerated, do not edit it, instead edit the Theme.sh file inside the rice directory.
## # (Gruvbox) Color scheme for Silvia Rice


# The basic colors
foreground              #fbf1c7
background              #282828
selection_foreground    #282828
selection_background    #fabd2f

# Cursor colors
cursor                  #fbf1c7
cursor_text_color       #282828

# URL underline color when hovering with mouse
url_color               #83a598

# Kitty window border colors
active_border_color     #d3869b
inactive_border_color   #a89984
bell_border_color       #fabd2f

# Tab bar colors
active_tab_foreground   #282828
active_tab_background   #d3869b
inactive_tab_foreground #fbf1c7
inactive_tab_background #a89984
tab_bar_background      #282828

# The 16 terminal colors

# black
color0 #a89984
color8 #a89984

# red
color1 #cc241d
color9 #fb4934

# green
color2  #98971a
color10 #b8bb26

# yellow
color3  #d79921
color11 #fabd2f

# blue
color4  #458588
color12 #83a598

# magenta
color5  #b16286
color13 #d3869b

# cyan
color6  #689d6a
color14 #8ec07c

# white
color7  #ebdbb2
color15 #ebdbb2
EOF

	killall -USR1 kitty
}

# Set compositor configuration
set_picom_config() {
	sed -i "$HOME"/.config/i3/picom.conf \
		-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
		-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
		-e "s/corner-radius = .*/corner-radius = 6/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'kitty'\"/\"100:class_g = 'kitty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst notification daemon config
set_dunst_config() {
	sed -i "$HOME"/.config/i3/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"#282828\"/g" \
		-e "s/separator_color = .*/separator_color = \"#d3869b\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='#d3869b'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/i3/dunstrc
	cat >>"$HOME"/.config/i3/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "#282828"
		foreground = "#fbf1c7"

		[urgency_normal]
		timeout = 6
		background = "#282828"
		foreground = "#fbf1c7"

		[urgency_critical]
		timeout = 0
		background = "#282828"
		foreground = "#fbf1c7"
	_EOF_
}

# Set eww colors
set_eww_colors() {
	cat >"$HOME"/.config/i3/eww/colors.scss <<EOF
// Eww colors for Silvia rice
\$bg: #282828;
\$bg-alt: #2E2E2E;
\$fg: #fbf1c7;
\$black: #a89984;
\$lightblack: #262831;
\$red: #fb4934;
\$blue: #83a598;
\$cyan: #8ec07c;
\$magenta: #d3869b;
\$green: #b8bb26;
\$yellow: #fabd2f;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Silvia
set_jgmenu_colors() {
	sed -i "$HOME"/.config/i3/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #282828/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #fbf1c7/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #2E2E2E/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #fbf1c7/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #a89984/'
}

# Set Rofi launcher config
set_launcher_config() {
	sed -i "$HOME/.config/i3/scripts/Launcher.rasi" \
		-e '22s/\(font: \).*/\1"scientifica 12";/' \
		-e 's/\(background: \).*/\1#282828;/' \
		-e 's/\(background-alt: \).*/\1#282828E0;/' \
		-e 's/\(foreground: \).*/\1#fbf1c7;/' \
		-e 's/\(selected: \).*/\1#d79921;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"

	sed -i "$HOME/.config/i3/scripts/Screenshot.rasi" \
		-e '22s/\(font: \).*/\1"scientifica 12";/' \
		-e 's/\(background: \).*/\1#282828;/' \
		-e 's/\(background-alt: \).*/\1#282828E0;/' \
		-e 's/\(foreground: \).*/\1#fbf1c7;/' \
		-e 's/\(selected: \).*/\1#d79921;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"

	# NetworkManager launcher
	sed -i "$HOME/.config/i3/scripts/NetManagerDM.rasi" \
		-e '12s/\(background: \).*/\1#282828;/' \
		-e '13s/\(background-alt: \).*/\1#2E2E2E;/' \
		-e '14s/\(foreground: \).*/\1#fbf1c7;/' \
		-e '15s/\(selected: \).*/\1#d79921;/' \
		-e '16s/\(active: \).*/\1#689d6a;/' \
		-e '17s/\(urgent: \).*/\1#fb4934;/'

	# WallSelect menu colors
	sed -i "$HOME/.config/i3/scripts/WallSelect.rasi" \
		-e 's/\(main-bg: \).*/\1#282828E6;/' \
		-e 's/\(main-fg: \).*/\1#fbf1c7;/' \
		-e 's/\(select-bg: \).*/\1#d79921;/' \
		-e 's/\(select-fg: \).*/\1#282828;/'
}

# Launch the bar
launch_bars() {

	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q cata-bar -c "${rice_dir}"/config.ini &
	done

}

### ---------- Apply Configurations ---------- ###

#set_bspwm_config
set_alacritty_config
set_kitty_config
set_picom_config
launch_bars
set_dunst_config
set_eww_colors
set_jgmenu_colors
set_launcher_config
