#!/usr/bin/env bash
#  ██████╗ ██████╗ ███████╗███╗   ██╗██████╗  █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔══██╗██╔══██╗██╔════╝████╗  ██║██╔══██╗██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  ██████╔╝██████╔╝█████╗  ██╔██╗ ██║██║  ██║███████║    ██████╔╝██║██║     █████╗
#  ██╔══██╗██╔══██╗██╔══╝  ██║╚██╗██║██║  ██║██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ██████╔╝██║  ██║███████╗██║ ╚████║██████╔╝██║  ██║    ██║  ██║██║╚██████╗███████╗
#  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Set bspwm configuration for Brenda
set_bspwm_config() {
	bspc config normal_border_color "#475258"
	bspc config active_border_color "#c0caf5"
	bspc config focused_border_color "#a7c080"
	bspc config presel_feedback_color "#e67e80"
}

set_i3_config() {
    # Define the new colors
	# colour of border, background, text, indicator, and child_border
    local focused="         #a7c080 #a7c080 #05313d #a7c080 #a7c080"
    local focused_inactive="#e67e80 #e67e80 #05313d #e67e80 #e67e80"
    local unfocused="       #e67e80 #e67e80 #05313d #e67e80 #e67e80"
    local urgent="          #e67e80 #e67e80 #05313d #e67e80 #e67e80"
    local placeholder="     #e67e80 #e67e80 #05313d #e67e80 #e67e80"

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
# (Everforest) color scheme for Brenda Rice

# Default colors
[colors.primary]
background = "#2d353b"
foreground = "#d3c6aa"

# Cursor colors
[colors.cursor]
cursor = "#d3c6aa"
text = "#2d353b"

# Normal colors
[colors.normal]
black   = "#475258"
red     = "#e67e80"
green   = "#a7c080"
yellow  = "#dbbc7f"
blue    = "#7fbbb3"
magenta = "#d699b6"
cyan    = "#83c092"
white   = "#d3c6aa"

# Bright colors
[colors.bright]
black   = "#475258"
red     = "#e67e80"
green   = "#a7c080"
yellow  = "#dbbc7f"
blue    = "#7fbbb3"
magenta = "#d699b6"
cyan    = "#83c092"
white   = "#d3c6aa"
EOF
}

# Set kitty colorscheme
set_kitty_config() {
	cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
## This file is autogenerated, do not edit it, instead edit the Theme.sh file inside the rice directory.
## (Everforest) color scheme for Brenda Rice


# The basic colors
foreground              #d3c6aa
background              #2d353b
selection_foreground    #2d353b
selection_background    #83c092

# Cursor colors
cursor                  #d3c6aa
cursor_text_color       #2d353b

# URL underline color when hovering with mouse
url_color               #7fbbb3

# Kitty window border colors
active_border_color     #d699b6
inactive_border_color   #475258
bell_border_color       #dbbc7f

# Tab bar colors
active_tab_foreground   #2d353b
active_tab_background   #d699b6
inactive_tab_foreground #d3c6aa
inactive_tab_background #475258
tab_bar_background      #2d353b

# The 16 terminal colors

# black
color0 #475258
color8 #475258

# red
color1 #e67e80
color9 #e67e80

# green
color2  #a7c080
color10 #a7c080

# yellow
color3  #dbbc7f
color11 #dbbc7f

# blue
color4  #7fbbb3
color12 #7fbbb3

# magenta
color5  #d699b6
color13 #d699b6

# cyan
color6  #83c092
color14 #83c092

# white
color7  #d3c6aa
color15 #d3c6aa
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
		-e "s/frame_color = .*/frame_color = \"#2d353b\"/g" \
		-e "s/separator_color = .*/separator_color = \"#d3c6aa\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='#7fbbb3'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/i3/dunstrc
	cat >>"$HOME"/.config/i3/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "#2d353b"
		foreground = "#d3c6aa"

		[urgency_normal]
		timeout = 6
		background = "#2d353b"
		foreground = "#d3c6aa"

		[urgency_critical]
		timeout = 0
		background = "#2d353b"
		foreground = "#d3c6aa"
	_EOF_
}

# Set eww colors
set_eww_colors() {
	cat >"$HOME"/.config/i3/eww/colors.scss <<EOF
// Eww colors for Brenda rice
\$bg: #2d353b;
\$bg-alt: #272e33;
\$fg: #d3c6aa;
\$black: #475258;
\$lightblack: #262831;
\$red: #e67e80;
\$blue: #7fbbb3;
\$cyan: #83c092;
\$magenta: #d699b6;
\$green: #a7c080;
\$yellow: #dbbc7f;
\$archicon: #0f94d2;
EOF
}

# Set jgmenu colors for Brenda
set_jgmenu_colors() {
	sed -i "$HOME"/.config/i3/jgmenurc \
		-e 's/color_menu_bg = .*/color_menu_bg = #2d353b/' \
		-e 's/color_norm_fg = .*/color_norm_fg = #d3c6aa/' \
		-e 's/color_sel_bg = .*/color_sel_bg = #475258/' \
		-e 's/color_sel_fg = .*/color_sel_fg = #d3c6aa/' \
		-e 's/color_sep_fg = .*/color_sep_fg = #a7c080/'
}

# Set Rofi launcher config
set_launcher_config() {
	sed -i "$HOME/.config/i3/scripts/Launcher.rasi" \
		-e '22s/\(font: \).*/\1"JetBrainsMono NF Bold 9";/' \
		-e 's/\(background: \).*/\1#2d353b;/' \
		-e 's/\(background-alt: \).*/\1#2d353bE0;/' \
		-e 's/\(foreground: \).*/\1#d3c6aa;/' \
		-e 's/\(selected: \).*/\1#475258;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"

	sed -i "$HOME/.config/i3/scripts/Screenshot.rasi" \
		-e '22s/\(font: \).*/\1"JetBrainsMono NF Bold 9";/' \
		-e 's/\(background: \).*/\1#2d353b;/' \
		-e 's/\(background-alt: \).*/\1#2d353bE0;/' \
		-e 's/\(foreground: \).*/\1#d3c6aa;/' \
		-e 's/\(selected: \).*/\1#475258;/' \
		-e "s/rices\/[[:alnum:]\-]*/rices\/${RICETHEME}/g"

	# NetworkManager launcher
	sed -i "$HOME/.config/i3/scripts/NetManagerDM.rasi" \
		-e '12s/\(background: \).*/\1#2d353b;/' \
		-e '13s/\(background-alt: \).*/\1#272e33;/' \
		-e '14s/\(foreground: \).*/\1#d3c6aa;/' \
		-e '15s/\(selected: \).*/\1#7fbbb3;/' \
		-e '16s/\(active: \).*/\1#a7c080;/' \
		-e '17s/\(urgent: \).*/\1#e67e80;/'

	# WallSelect menu colors
	sed -i "$HOME/.config/i3/scripts/WallSelect.rasi" \
		-e 's/\(main-bg: \).*/\1#2d353bE6;/' \
		-e 's/\(main-fg: \).*/\1#d3c6aa;/' \
		-e 's/\(select-bg: \).*/\1#475258;/' \
		-e 's/\(select-fg: \).*/\1#2d353b;/'
}

# Launch the bar
launch_bars() {

	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q brenda -c "${rice_dir}"/config.ini &
	done

}

### ---------- Apply Configurations ---------- ###

set_i3_config
set_alacritty_config
set_kitty_config
set_picom_config
launch_bars
set_eww_colors
set_jgmenu_colors
set_dunst_config
set_launcher_config
