#!/bin/bash

# Settings
declare -a LIST_OF_WINDOW_TITLES_THAT_PREVENT_LOCKING=(
  "YouTube"
  "vlc"
  "mpv"
)

# Dependencies
AWK=/usr/bin/awk
GREP=/usr/bin/grep
XPROP=/usr/bin/xprop

# Find active window id
get_active_id() {
  $XPROP -root | $AWK '$1 ~ /_NET_ACTIVE_WINDOW/ { print $5 }'
}

# Determine a window's title text by it's ID
get_window_title() {
  # For mplayer or vlc, we might need to check WM_CLASS(STRING), idk.
  $XPROP -id $1 | $AWK -F '=' '$1 ~ /_NET_WM_NAME\(UTF8_STRING\)/ { print $2 }'
}

# Determine if a window is fullscreen based on it's ID
is_fullscreen() {
  $XPROP -id $1 | $AWK -F '=' '$1 ~ /_NET_WM_STATE\(ATOM\)/ { for (i=2; i<=3; i++) if ($i ~ /FULLSCREEN/) exit 0; exit 1 }'
  return $?
}

# Determine if the locker command should run based on which windows are
# fullscreened.
should_lock() {
  id=$(get_active_id)
  title=$(get_window_title $id)

  # if is_fullscreen $id; then
  #     for i in "${LIST_OF_WINDOW_TITLES_THAT_PREVENT_LOCKING[@]}"; do
  #         if [[ $title =~ $i ]]; then
  #             return 1
  #         fi
  #     done
  # else
  #     return 0
  # fi

  for i in "${LIST_OF_WINDOW_TITLES_THAT_PREVENT_LOCKING[@]}"; do
    # 比较是否包含字符
    if [[ $title =~ $i ]]; then
      return 1
    fi
  done

  return 0

}

# main()
# 如果为0则执行
if should_lock; then
  # $HOME/scripts/lock_screen_scrot.sh $HOME/images/scythman.png

  # 更新缓存的锁屏壁纸
  # betterlockscreen -u ~/Wallpapers/image.png --fx dim,pixel
  # 更换锁屏壁纸及壁纸的样式
  # betterlockscreen -w pixel
  #锁屏
  betterlockscreen -l
fi
