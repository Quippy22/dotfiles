--------------------------------------------
---- SERPANTINUM EXTRA KEYBINDINGS ---------
---- Modular binds that preserve core binds -
--------------------------------------------

return function(mainMod)
    -- App Launcher (Alternative to SUPER + SPACE, which also launches serpantinum launcher via style.apps.launcher)
    hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("serpantinum msg toggle launcher"))

    -- Clipboard Manager (SUPER + SHIFT + V and SUPER + Y preserve SUPER + C for close window & SUPER + V for float)
    hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("serpantinum msg toggle clipboard"))
    hl.bind(mainMod .. " + Y",         hl.dsp.exec_cmd("serpantinum msg toggle clipboard"))

    -- Calendar & Notification Center (SUPER + N and SUPER + ALT + C preserve SUPER + S for screenshot)
    hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd("serpantinum msg toggle calendar"))
    hl.bind(mainMod .. " + ALT + C",   hl.dsp.exec_cmd("serpantinum msg toggle calendar"))

    -- System Dashboard & Control Center (SUPER + B, SUPER + I, and SUPER + ALT + D preserve SUPER + M for shutdown)
    hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("serpantinum msg toggle system"))
    hl.bind(mainMod .. " + I",         hl.dsp.exec_cmd("serpantinum msg toggle system"))
    hl.bind(mainMod .. " + ALT + D",   hl.dsp.exec_cmd("serpantinum msg toggle system"))

    -- Keybindings Search & Help Menu (SUPER + ? / SUPER + /)
    hl.bind(mainMod .. " + question",    hl.dsp.exec_cmd("~/dotfiles/scripts/keybinds_help.sh"))
    hl.bind(mainMod .. " + slash",       hl.dsp.exec_cmd("~/dotfiles/scripts/keybinds_help.sh"))
    hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.exec_cmd("~/dotfiles/scripts/keybinds_help.sh"))

    -- Lockscreen (SUPER + ALT + L preserves SUPER + L for Vim focus right)
    hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("serpantinum lock"), { repeating = true, locked = true })
    hl.bind("XF86PowerOff", hl.dsp.exec_cmd("serpantinum lock"), { locked = true })

    -- Music / Media Widget (SUPER + ALT + M preserves SUPER + M for shutdown/exit)
    hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("serpantinum msg toggle music"))

    -- Bar / Dock Autohide Toggle
    hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("serpantinum msg bar autohide"))

    -- Wallpaper Selector (Serpantinum native wallpaper picker)
    hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("serpantinum msg toggle wallpaper"))

    -- Network Menu
    hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("serpantinum msg toggle network"))

    -- Volume Menu
    hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("serpantinum msg toggle volume"))

    -- Settings Window (SUPER + comma preserves SUPER + H for Vim focus left)
    hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd("serpantinum msg toggle settings"))

    -- Desktop Redactor (Widget Layout Editor)
    hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd("serpantinum redactor"))

    -- Reload Serpantinum Shell (SUPER + ALT + R preserves SUPER + R for togglesplit)
    hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd("serpantinum reload"))

    -- Screenshots (Hardware PrintScreen keys using Serpantinum tools)
    hl.bind("Print", hl.dsp.exec_cmd("serpantinum screenshot --edit"), { locked = true })
    hl.bind("SHIFT + Print", hl.dsp.exec_cmd("serpantinum screenshot"), { locked = true })
    hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("serpantinum screenshot --full"), { locked = true })
    hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("serpantinum screenshot --full --edit"), { locked = true })
end
