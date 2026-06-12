-----------------------
---- MOUSE SUBMAP ----
-----------------------

local mainMod = "SUPER"

local function notify(text)
    hl.notification.create({
        text = text,
        timeout = 2000,
    })
end

local function mouse_move(dx, dy)
    return function()
        local cursor = hl.get_cursor_pos()
        if cursor == nil then
            return
        end

        hl.dispatch(hl.dsp.cursor.move({
            x = math.floor(cursor.x + dx + 0.5),
            y = math.floor(cursor.y + dy + 0.5),
        }))
    end
end

local function mouse_click(key)
    return function()
        hl.dispatch(hl.dsp.send_key_state({
            mods = "",
            key = key,
            state = "down",
            window = "activewindow",
        }))
        hl.dispatch(hl.dsp.send_key_state({
            mods = "",
            key = key,
            state = "up",
            window = "activewindow",
        }))
    end
end

local function mouse_scroll(key)
    return function()
        hl.dispatch(hl.dsp.send_key_state({
            mods = "",
            key = key,
            state = "down",
            window = "activewindow",
        }))
        hl.dispatch(hl.dsp.send_key_state({
            mods = "",
            key = key,
            state = "up",
            window = "activewindow",
        }))
    end
end

hl.bind(mainMod .. " + ALT + M", function()
    notify("Mouse mode: on")
    hl.dispatch(hl.dsp.submap("mouse"))
end)

hl.define_submap("mouse", function()
    hl.bind("H", mouse_move(-20, 0), { repeating = true })
    hl.bind("J", mouse_move(0, 20), { repeating = true })
    hl.bind("K", mouse_move(0, -20), { repeating = true })
    hl.bind("L", mouse_move(20, 0), { repeating = true })

    hl.bind("SHIFT + H", mouse_move(-5, 0), { repeating = true })
    hl.bind("SHIFT + J", mouse_move(0, 5), { repeating = true })
    hl.bind("SHIFT + K", mouse_move(0, -5), { repeating = true })
    hl.bind("SHIFT + L", mouse_move(5, 0), { repeating = true })

    hl.bind("CTRL + H", mouse_move(-100, 0), { repeating = true })
    hl.bind("CTRL + J", mouse_move(0, 100), { repeating = true })
    hl.bind("CTRL + K", mouse_move(0, -100), { repeating = true })
    hl.bind("CTRL + L", mouse_move(100, 0), { repeating = true })

    hl.bind("F", mouse_click("mouse:272"))
    hl.bind("D", mouse_click("mouse:273"))
    hl.bind("A", mouse_scroll("mouse_up"), { repeating = true })
    hl.bind("S", mouse_scroll("mouse_down"), { repeating = true })

    hl.bind("escape", function()
        notify("Mouse mode off")
        hl.dispatch(hl.dsp.submap("reset"))
    end)
end)
