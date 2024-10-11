#!/usr/bin/env bash
#   ██████╗██████╗ ██╗███████╗████████╗██╗███╗   ██╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔════╝██╔══██╗██║██╔════╝╚══██╔══╝██║████╗  ██║██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ██║     ██████╔╝██║███████╗   ██║   ██║██╔██╗ ██║███████║    ██████╔╝██║██║     █████╗
#  ██║     ██╔══██╗██║╚════██║   ██║   ██║██║╚██╗██║██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ╚██████╗██║  ██║██║███████║   ██║   ██║██║ ╚████║██║  ██║    ██║  ██║██║╚██████╗███████╗
#   ╚═════╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Cristina
set_bspwm_config() {
	bspc config border_width 0
	bspc config top_padding 2
	bspc config bottom_padding 60
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config normal_border_color "#9bced7"
	bspc config active_border_color "#9bced7"
	bspc config focused_border_color "#c3a5e6"
	bspc config presel_feedback_color "#c3a5e6"
}

set_i3_config() {
    # Define the new colors
	# colour of border, background, text, indicator, and child_border
    local focused="         #a66bec #a66bec #05313d #a66bec #a66bec"
    local focused_inactive="#9bced7 #9bced7 #05313d #9bced7 #9bced7"
    local unfocused="       #9bced7 #9bced7 #05313d #9bced7 #9bced7"
    local urgent="          #9bced7 #9bced7 #05313d #9bced7 #9bced7"
    local placeholder="     #9bced7 #9bced7 #05313d #9bced7 #9bced7"

    # Update the i3 config file, replacing only the color codes
    sed -i.bak \
        -e "s/^client.focused\s.*/client.focused $focused/" \
        -e "s/^client.focused_inactive\s.*/client.focused_inactive $focused_inactive/" \
        -e "s/^client.unfocused\s.*/client.unfocused $unfocused/" \
        -e "s/^client.urgent\s.*/client.urgent $urgent/" \
        -e "s/^client.placeholder\s.*/client.placeholder $placeholder/" \
        ~/.config/i3/config

    # Inform the user
    echo "i3 configuration updated with new color settings."
}

# Set alacritty colorscheme
set_alacritty_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# (Rose-Pine Moon) Color scheme for Cristina Rice

# Default colors
[colors.primary]
background = "#232136"
foreground = "#e0def4"

# Cursor colors
[colors.cursor]
cursor = "#c3a5e6"
text = "#232136"

# Normal colors
[colors.normal]
black = "#393552"
blue = "#34738e"
cyan = "#eabbb9"
green = "#9bced7"
magenta = "#c3a5e6"
red = "#ea6f91"
white = "#faebd7"
yellow = "#f1ca93"

# Bright colors
[colors.bright]
black = "#6e6a86"
blue = "#34738e"
cyan = "#ebbcba"
green = "#9bced7"
magenta = "#c3a5e6"
red = "#ea6f91"
white = "#e0def4"
yellow = "#f1ca93"
EOF
}

# Set kitty colorscheme
set_kitty_config() {
	cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
## This file is autogenerated, do not edit it, instead edit the Theme.sh file inside the rice directory.
## (Rose-Pine Moon) Color scheme for Cristina Rice


# The basic colors
foreground              #e0def4
background              #232136
selection_foreground    #232136
selection_background    #eabbb9

# Cursor colors
cursor                  #c3a5e6
cursor_text_color       #232136

# URL underline color when hovering with mouse
url_color               #34738e

# Kitty window border colors
active_border_color     #c3a5e6
inactive_border_color   #6e6a86
bell_border_color       #f1ca93

# Tab bar colors
active_tab_foreground   #232136
active_tab_background   #c3a5e6
inactive_tab_foreground #e0def4
inactive_tab_background #393552
tab_bar_background      #232136

# The 16 terminal colors

# black
color0 #393552
color8 #6e6a86

# red
color1 #ea6f91
color9 #ea6f91

# green
color2  #9bced7
color10 #9bced7

# yellow
color3  #f1ca93
color11 #f1ca93

# blue
color4  #34738e
color12 #34738e

# magenta
color5  #c3a5e6
color13 #c3a5e6

# cyan
color6  #eabbb9
color14 #ebbcba

# white
color7  #faebd7
color15 #e0def4
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
		-e "s/frame_color = .*/frame_color = \"#232136\"/g" \
		-e "s/separator_color = .*/separator_color = \"#ea6f91\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='#9bced7'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/i3/dunstrc
	cat >>"$HOME"/.config/i3/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "#232136"
		foreground = "#e0def4"

		[urgency_normal]
		timeout = 6
		background = "#232136"
		foreground = "#e0def4"

		[urgency_critical]
		timeout = 0
		background = "#232136"
		foreground = "#e0def4"
	_EOF_
}

# Set eww colors
set_eww_colors() {
	cat >"$HOME"/.config/i3/eww/colors.scss <<EOF
// Eww colors for Cristina rice
\$bg: #232136;
\$bg-alt: #2a2740;
\$fg: #e0def4;
\$black: #6f6e85;
\$lightblack: #262831;
\$red: #ea6f91;
\$blue: #34738e;
\$cyan: #eabbb9;
\$magenta: #c3a5e6;
\$green: #9bced7;
\$yellow: #f1ca93;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Cristina
set_jgmenu_colors() {
	sed -i "$HOME"/.config/i3/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #232136/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #e0def4/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #2a2740/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #e0def4/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #6f6e85/'
}

# Set Rofi launcher config
set_launcher_config() {
	sed -i "$HOME/.config/i3/scripts/Launcher.rasi" \
		-e '22s/\(font: \).*/\1"Terminess Nerd Font Mono Bold 10";/' \
		-e 's/\(background: \).*/\1#232136;/' \
		-e 's/\(background-alt: \).*/\1#232136E0;/' \
		-e 's/\(foreground: \).*/\1#e0def4;/' \
		-e 's/\(selected: \).*/\1#c3a5e6;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"

	sed -i "$HOME/.config/i3/scripts/Screenshot.rasi" \
		-e '22s/\(font: \).*/\1"Terminess Nerd Font Mono Bold 10";/' \
		-e 's/\(background: \).*/\1#232136;/' \
		-e 's/\(background-alt: \).*/\1#232136E0;/' \
		-e 's/\(foreground: \).*/\1#e0def4;/' \
		-e 's/\(selected: \).*/\1#c3a5e6;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"

	# NetworkManager launcher
	sed -i "$HOME/.config/i3/scripts/NetManagerDM.rasi" \
		-e '12s/\(background: \).*/\1#232136;/' \
		-e '13s/\(background-alt: \).*/\1#2a2740;/' \
		-e '14s/\(foreground: \).*/\1#e0def4;/' \
		-e '15s/\(selected: \).*/\1#c3a5e6;/' \
		-e '16s/\(active: \).*/\1#9bced7;/' \
		-e '17s/\(urgent: \).*/\1#ea6f91;/'

	# WallSelect menu colors
	sed -i "$HOME/.config/i3/scripts/WallSelect.rasi" \
		-e 's/\(main-bg: \).*/\1#232136E6;/' \
		-e 's/\(main-fg: \).*/\1#e0def4;/' \
		-e 's/\(select-bg: \).*/\1#c3a5e6;/' \
		-e 's/\(select-fg: \).*/\1#232136;/'
}

# Launch the bar and or eww widgets
launch_bars() {

	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q cristina-bar -c "${rice_dir}"/config.ini &
	done

}

### ---------- Apply Configurations ---------- ###

set_i3_config
set_alacritty_config
set_kitty_config
set_picom_config
launch_bars
set_dunst_config
set_eww_colors
set_jgmenu_colors
set_launcher_config
