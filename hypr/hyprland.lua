-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Converted from hyprland.conf / look.conf / keybindings.conf / windows.conf
-- on 2026-08-21. See the TODO comments in this file and in look.lua,
-- keybindings.lua, and windows.lua for the handful of spots that need a
-- manual check against your installed Hyprland version - a few dispatcher
-- and rule-field names couldn't be confirmed from the docs available at
-- conversion time. Consider also running your original .conf files through
-- one of the community converters (e.g. hyprconf2lua or hyprlang2lua) as a
-- cross-check before deleting the old files.

hl.config({
    debug = {
        disable_logs = false,
    },
})

-- `source =` becomes `require()`. Paths resolve relative to where
-- hyprland.lua lives, and the .lua extension is left off.
require("look")
require("keybindings")
require("windows")

-- NOTE: the old file also had `source = ~/.cache/wal/colors-hyprland.conf`
-- here. That's now handled inside look.lua, which is the only file that
-- actually uses the pywal color variables - see the TODO(colors) note there.

-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- exec-once -> subscribe to the "hyprland.start" event, which fires once per session.
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- hl.exec_cmd("iio-hyprland")
    hl.exec_cmd("kbuildsycoca6")
    hl.exec_cmd("iio-sensor-proxy")
    -- hl.exec_cmd("~/.config/hypr/scripts/rotate-screen.sh")
    hl.exec_cmd("protonvpn-app")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd('xremap --device "UGTABLET UGEE S640 Keyboard" --watch $HOME/.config/xremap/config.yml')
    -- hl.exec_cmd("~/.config/hypr/scripts/auto_restart_waybar.sh")

    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/mute_on_startup.sh")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/battery_notify.sh")
    hl.exec_cmd("waybar & cb & nm-applet --indicator &")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE")
    hl.exec_cmd("hyprpm reload")
    hl.exec_cmd("wvkbd-deskintl --hidden")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/localsend_minimised.sh")
    hl.exec_cmd("systemctl --user start lan-mouse.service")

    hl.exec_cmd('printf "[D-BUS Service]\\nName=org.kde.kded6\\nExec=/bin/false" > $HOME/.local/share/dbus-1/services/org.kde.kded6.service')
end)

-- TODO(exec vs exec-once): the old file used plain `exec =` (not `exec-once`)
-- for these two, which in hyprlang re-runs the command on every config
-- reload, not just at startup. I couldn't confirm a direct Lua equivalent of
-- that "runs on every reload" semantic from the docs on hand. The Lua file
-- itself re-executes top-to-bottom on `hyprctl reload`, so calling
-- hl.exec_cmd() directly (outside hl.on(...)) below should be a reasonable
-- match - but please verify against the Autostart wiki page and adjust if
-- Hyprland gives you a `hyprland.reload` event to hook instead.
hl.exec_cmd("hyprshade auto") -- TODO: verify exec-on-reload semantics, see above
hl.exec_cmd("swaync") -- Notification Daemon -- TODO: verify exec-on-reload semantics, see above

-- hl.exec_cmd("ln -s $XDG_RUNTIME_DIR/hypr /tmp/hypr")

hl.config({
    render = {
        cm_enabled = false,
    },
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XDG_MENU_PREFIX", "arch-")
-- hl.env("LD_LIBRARY_PATH", "/home/danny/libboost_locale_miktex/usr/lib/:$LD_LIBRARY_PATH")
-- hl.env("LD_LIBRARY_PATH", "/home/danny/libboost_locale_miktex/icu-76.1-1-x86_64.pkg/usr/lib/:$LD_LIBRARY_PATH")

-- hl.env("GSK_RENDERER", "gl")

-- TODO(exec-shutdown): no confirmed Lua equivalent found for `exec-shutdown`
-- in the docs available at conversion time. Best guess is a shutdown/exit
-- event to hook via hl.on() - verify the actual event name (something like
-- "hyprland.exit") against the Expanding-functionality wiki page.
-- hl.on("hyprland.exit", function()
--     hl.exec_cmd('rm ' .. os.getenv("HOME") .. '/.local/share/dbus-1/services/org.kde.kded6.service')
-- end)

---------------------
---- PERMISSIONS ----
---------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not
-- applied on-the-fly for security reasons.

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-------------------------
---- LID SWITCH BINDS ----
-------------------------
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock & systemctl suspend"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms off"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"), { locked = true })
-- hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("pkill ~/.config/hypr/scripts/rotate-screen.sh"), { locked = true })
-- hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/rotate-screen.sh"), { locked = true })
