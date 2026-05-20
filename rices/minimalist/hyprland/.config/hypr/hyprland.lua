-- Minimalist Hyprland Lua Config

require("env")
require("monitors")
require("settings")
require("rules")
require("autostart")
require("keybinds")
hl.layer_rule({
    name = "waybar-order",
    match = { namespace = "waybar" },
    order = -1,
})
