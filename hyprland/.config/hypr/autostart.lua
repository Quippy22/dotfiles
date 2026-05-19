-------------------
---- AUTOSTART ----
-------------------

local terminal = "kitty"

hl.on("hyprland.start", function ()
  hl.exec_cmd("xrdb -merge ~/.Xresources")
  hl.exec_cmd("hyprctl setcursor Nordzy-cursors 24")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("xdg-desktop-portal-hyprland &")
  hl.exec_cmd("xdg-desktop-portal &")

  -- Apps to launch on workspace 3
  hl.exec_cmd("[workspace 3 silent] youtube-music")
  hl.exec_cmd('sh -c "hyprctl dispatch workspace 3; discord & sleep 5; hyprctl dispatch workspace 1"')
  hl.exec_cmd("hyprctl dispatch workspace 1")
  hl.exec_cmd("[workspace special:persist silent] kitty --class persist-term")

  -- Dark themes
  hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
  hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"')
  hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-theme "Nordzy-cursors"')
  hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-size 24')
end)
