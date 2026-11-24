#!/usr/bin/env bash
# Zero-CPU RandR resize watcher that keeps XFCE top bar and bottom dock
# floating with clean margins and centered on any TigerVNC window resize.
set -u

center_panels() {
  local w h cx top_y bot_y
  read -r w h <<< "$(xdpyinfo | awk "/dimensions:/{split(\$2,a,\"x\"); print a[1], a[2]}")"
  [[ -n "${w:-}" && -n "${h:-}" ]] || return
  cx=$((w / 2))
  top_y=45
  bot_y=$((h - 57))
  xfconf-query -c xfce4-panel -p /panels/panel-1/position -n -t string -s "p=0;x=${cx};y=${top_y}" 2>/dev/null || true
  xfconf-query -c xfce4-panel -p /panels/panel-2/position -n -t string -s "p=0;x=${cx};y=${bot_y}" 2>/dev/null || true
}

center_panels
xev -root -event randr 2>/dev/null | while IFS= read -r line; do
  if [[ "$line" == *"RRScreenChangeNotify"* ]]; then
    center_panels
  fi
done
