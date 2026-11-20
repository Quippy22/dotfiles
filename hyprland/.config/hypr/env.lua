-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

local home = os.getenv("HOME") or ""
local current_path = os.getenv("PATH") or ""
local local_bin = home .. "/.local/bin"
if not current_path:find(local_bin, 1, true) then
    hl.env("PATH", local_bin .. ":" .. current_path)
end
hl.env("HYPRCURSOR_THEME", "Nordzy-hyprcursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Nordzy-cursors")
hl.env("XCURSOR_SIZE", "24")

-- NVIDIA specific
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
