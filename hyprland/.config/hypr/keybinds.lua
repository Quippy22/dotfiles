---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "wofi --show drun --layer=overlay"

local function toggle_persist_term()
    for _, window in ipairs(hl.get_windows()) do
        if window.class == "persist-term" then
            hl.dispatch(hl.dsp.workspace.toggle_special("persist"))
            return
        end
    end

    local activeSpecial = hl.get_active_special_workspace()
    if activeSpecial == nil or activeSpecial.name ~= "persist" then
        hl.dispatch(hl.dsp.workspace.toggle_special("persist"))
    end

    hl.exec_cmd("kitty --class persist-term")
end

local function resize_from_edge(dx, dy)
    return function()
        local window = hl.get_active_window()
        local isFloating = window ~= nil and (window.floating == true or window.float == true)

        hl.dispatch(hl.dsp.window.resize({ x = dx, y = dy, relative = true }))

        if not isFloating then
            return
        end

        if dx ~= 0 then
            hl.dispatch(hl.dsp.window.move({
                x = math.floor(-dx / 2),
                y = 0,
                relative = true,
            }))
        end

        if dy ~= 0 then
            hl.dispatch(hl.dsp.window.move({
                x = 0,
                y = math.floor(-dy / 2),
                relative = true,
            }))
        end
    end
end

-- General Binds
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L",  hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",  hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Move windows with mainMod + SHIFT + hjkl
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Resize windows with mainMod + ALT + hjkl
hl.bind(mainMod .. " + ALT + H", resize_from_edge(-40, 0), { repeating = true })
hl.bind(mainMod .. " + ALT + L", resize_from_edge(40, 0), { repeating = true })
hl.bind(mainMod .. " + ALT + K", resize_from_edge(0, -40), { repeating = true })
hl.bind(mainMod .. " + ALT + J", resize_from_edge(0, 40), { repeating = true })

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Personal keybinds
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Images/screenshots -c"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m window ~/Images/screenshots -c"))
hl.bind(mainMod .. " + SHIFT + RETURN", toggle_persist_term)
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/dotfiles/scripts/rice_selector.sh"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/dotfiles/scripts/wallpaper_selector.sh"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
