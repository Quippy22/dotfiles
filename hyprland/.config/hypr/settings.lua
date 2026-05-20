-----------------------
---- LOOK AND FEEL ----
-----------------------

local style = require("style")

hl.config(style.config)

for name, curve in pairs(style.curves) do
    hl.curve(name, curve)
end

for _, animation in ipairs(style.animation_rules) do
    hl.animation(animation)
end

for _, gesture in ipairs(style.gestures or {}) do
    hl.gesture(gesture)
end

for _, device in ipairs(style.devices or {}) do
    hl.device(device)
end
