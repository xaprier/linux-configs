#!/usr/bin/bash
cift=' '
tek=''
current='Şu andaki ekran düzeni: '

if [[ $(xrandr --query | grep "current " | cut -d" " -f8) -eq "3840" ]]; then
    current+='Çift Ekran'
else
    current+='Tek Ekran'
fi

MONITORS=()
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ -z $m ]]; then
        continue
    fi
    MONITORS+=("$m")
done

MONITORS=("0:${MONITORS[@]}")

if [[ ${#MONITORS[@]} -ge 1 ]]; then
    chosen=$(printf '%s;%s;' "$tek" "$cift" |
        rofi -p "$current" \
            -dmenu \
            -sep ';' \
            -selected-row 0 -theme $HOME/.config/rofi/applets/type-4/style-3.rasi)
else
    chosen=$(printf '%s;' "$tek" |
        rofi -p "$current" \
            -dmenu \
            -sep ';' \
            -selected-row 0 -theme $HOME/.config/rofi/applets/type-4/style-3.rasi)
fi

case "$chosen" in
"$cift") action='xrandr --output HDMI-0 --right-of eDP-1-1' ;;
"$tek") action='xrandr --output HDMI-0 --same-as eDP-1-1' ;;
*) exit 1 ;;
esac

eval "$action"
eval "bash $HOME/.config/polybar/launchpolybar.sh"
