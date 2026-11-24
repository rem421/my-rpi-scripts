#!/usr/bin/env bash
set -e

echo "[INFO] Applying Material Design 3 theme and floating panel settings to XFCE..."

# GTK3, Icons, Window Manager & CSD dialogs
xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "Orchis-Purple-Dark-Compact"
xfconf-query -c xsettings -p /Net/IconThemeName -n -t string -s "Tela-circle-purple-dark"
xfconf-query -c xsettings -p /Gtk/DialogsUseHeader -n -t bool -s true

# Lightweight XRender compositing in xfwm4 (works in TigerVNC without GPU)
xfconf-query -c xfwm4 -p /general/theme -n -t string -s "Orchis-Purple-Dark-Compact"
xfconf-query -c xfwm4 -p /general/vblank_mode -n -t string -s "off"
xfconf-query -c xfwm4 -p /general/use_compositing -n -t bool -s true
xfconf-query -c xfwm4 -p /general/show_frame_shadow -n -t bool -s true
xfconf-query -c xfwm4 -p /general/show_popup_shadow -n -t bool -s true

# Hide default desktop icons
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -n -t bool -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -n -t bool -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -n -t bool -s false

# Top bar (panel-1): clean, minimal, no workspace pager, transparent end spacer
xfconf-query -c xfce4-panel -p /panels/panel-1/size -n -t int -s 32
xfconf-query -c xfce4-panel -p /panels/panel-1/icon-size -n -t int -s 16
xfconf-query -c xfce4-panel -p /panels/panel-1/length -n -t int -s 98
xfconf-query -c xfce4-panel -p /panels/panel-1/background-style -n -t int -s 0
xfconf-query -c xfce4-panel -p /plugins/plugin-1/show-button-title -n -t bool -s false
xfconf-query -c xfce4-panel -p /plugins/plugin-2/show-labels -n -t bool -s false
xfconf-query -c xfce4-panel -p /plugins/plugin-2/flat-buttons -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-2/show-handle -n -t bool -s false
xfconf-query -c xfce4-panel -p /plugins/plugin-5/style -n -t int -s 0
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids \
  -t int -s 1 -t int -s 2 -t int -s 3 -t int -s 6 -t int -s 8 -t int -s 9 \
  -t int -s 10 -t int -s 11 -t int -s 12 -t int -s 13 -t int -s 14 -t int -s 5

# Bottom dock (panel-2)
xfconf-query -c xfce4-panel -p /panels/panel-2/size -n -t int -s 48
xfconf-query -c xfce4-panel -p /panels/panel-2/icon-size -n -t int -s 28
xfconf-query -c xfce4-panel -p /panels/panel-2/autohide-behavior -n -t int -s 0
xfconf-query -c xfce4-panel -p /panels/panel-2/background-style -n -t int -s 0

# GNOME/Libadwaita apps (Nautilus + GNOME Terminal CSD)
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Orchis-Purple-Dark-Compact"
gsettings set org.gnome.desktop.interface icon-theme "Tela-circle-purple-dark"
gsettings set org.gnome.Terminal.Legacy.Settings headerbar true
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant "dark"

PROF=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "\047")
PPATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROF/"
gsettings set "$PPATH" use-theme-colors false
gsettings set "$PPATH" background-color "#1c1922"
gsettings set "$PPATH" foreground-color "#e8e4ef"
gsettings set "$PPATH" scrollbar-policy "never"

xfce4-panel -r
echo "[SUCCESS] XFCE Material Design 3 configuration applied."
