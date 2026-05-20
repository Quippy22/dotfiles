-- Hyprland Lua Modular Config

local style = require("style")

require("env")
require("monitors")
require("settings")
require("rules")
require("autostart")
require("keybinds")
hl.layer_rule({
    name = "waybar-order",
    match = { namespace = "waybar" },
    order = style.waybar.order,
})
