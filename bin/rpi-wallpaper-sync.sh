#!/usr/bin/env bash
# Zero-CPU DBus watcher: when you click "Set as Wallpaper..." in Nautilus (Files),
# automatically syncs that wallpaper to XFCE (xfce4-desktop).
set -u

apply_uri() {
  local raw="$1"
  local path
  path=$(python3 -c "import sys, urllib.parse; u = sys.argv[1].strip().strip(\"\047\\\"\"); print(urllib.parse.unquote(urllib.parse.urlparse(u).path) if u.startswith(\"file://\") else u)" "$raw" 2>/dev/null)
  [[ -f "$path" ]] || return
  for prop in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep "last-image"); do
    xfconf-query -c xfce4-desktop -p "$prop" -s "$path" 2>/dev/null || true
  done
  for prop in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep "image-style"); do
    xfconf-query -c xfce4-desktop -p "$prop" -s 5 2>/dev/null || true
  done
}

gsettings monitor org.gnome.desktop.background 2>/dev/null | while IFS= read -r line; do
  case "$line" in
    picture-uri:*|picture-uri-dark:*)
      apply_uri "${line#*: }"
      ;;
  esac
done
