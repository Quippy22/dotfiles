-------------------
---- AUTOSTART ----
-------------------

local style = require("style")
local terminal = style.apps.terminal
local persistTerm = style.persistent_terminal

hl.on("hyprland.start", function ()
  hl.exec_cmd("xrdb -merge ~/.Xresources")
  hl.exec_cmd("hyprctl setcursor Nordzy-cursors 24")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("sh -c 'sleep 0.2; ~/dotfiles/scripts/apply_hypr_style.sh'")
  if style.shell == "serpantinum" then
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("serpantinumd start")
  else
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
  end
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland & sleep 2 && /usr/lib/xdg-desktop-portal &")

  -- Apps to launch on workspace 3
  hl.exec_cmd("discord")
  hl.exec_cmd([[sh -c 'sleep 2; hyprctl dispatch workspace 1']])
  hl.exec_cmd("~/dotfiles/scripts/run_all_coding_scripts.sh")
  hl.exec_cmd(string.format("[workspace %s silent] %s --class %s", persistTerm.workspace, terminal, persistTerm.class))
end)
