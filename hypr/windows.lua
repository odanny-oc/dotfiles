------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- hl.monitor({ output = "", mode = "preferred", position = "1920x1080@60", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
-- hl.monitor({ output = "sunshine_1", mode = "1920x1080@60", position = "0x-1080", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@59.95", position = "0x-1440", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x-1080", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "auto", scale = 1, mirror = "eDP-1" })
-- hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "0x-2160", scale = 1.5 })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })

-- TODO(wslayout plugin): `layoutopt:wslayout-layout:master` / `:dwindle` came
-- from the wslayout plugin's per-workspace layout override. I couldn't find a
-- confirmed hl.workspace_rule field name for this in the wiki - it may still
-- be plugin-managed and unaffected by the Lua rewrite, or it may have gained
-- its own hl binding. Check the wslayout plugin's own docs/repo for the
-- current syntax; left commented below so nothing silently breaks.
-- hl.workspace_rule({ workspace = "1", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "2", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "3", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "4", layoutopt = "wslayout-layout:dwindle" })
-- hl.workspace_rule({ workspace = "5", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "6", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "7", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "8", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "9", layoutopt = "wslayout-layout:master" })
-- hl.workspace_rule({ workspace = "10", layoutopt = "wslayout-layout:master" })

-- Opacity rules
hl.window_rule({ match = { class = "^(com.mitchellh.ghostty)$" }, opacity = "0.9 0.75" })

-- Floating windows
hl.window_rule({ match = { class = "^(org.pulseaudio.pavucontrol)$" }, float = true })
hl.window_rule({ match = { class = "org.freedesktop.impl.portal.desktop.kde" }, float = true, center=true,  size = {1000, 700} })
hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
-- TODO(negative match): the original used `match:title negative:^(...)$ ` to
-- EXCLUDE windows whose title matches the pattern. I couldn't confirm the
-- Lua match-table syntax for negated matches in the search results - the
-- field name below (`title_negative`) is a guess, verify against the
-- Window Rules wiki page's "match" section for your installed version.
hl.window_rule({
    match = { class = "^(org.inkscape.Inkscape)$", title = "negative:^(New document 1 - Inkscape)$" }, -- TODO: verify negative-match field name
    float = true,
    size = {800, 600},
})

-- Workspace assignment
hl.window_rule({ match = { class = "^(com.vixalien.sticky)$" }, workspace = "10", float = true, size = {400, 400} })
hl.window_rule({ match = { class = "^(elecwhat)$" }, workspace = "9" })
hl.window_rule({ match = { class = "^(firefox)$" }, workspace = "2" })
hl.window_rule({ match = { class = "^firefox$", title = ".* \\.pdf" }, workspace = "3" })
hl.window_rule({ match = { class = "^(SPIS)$" }, workspace = "4" })
hl.window_rule({ match = { class = "^(org.mozilla.Thunderbird)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(org.pwmt.zathura)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(com.github.flxzt.rnote)$" }, workspace = "1" })
hl.window_rule({ match = { class = "^(Spotify)$" }, workspace = "10" })
hl.window_rule({ match = { class = "^(org.localsend.localsend_app)$" }, workspace = "10 silent" })
hl.window_rule({ match = { class = "^(python3|Matplotlib|matplotlib|org.matplotlib.Matplotlib3)$" }, workspace = "8 silent" })

-- xwaylandvideobridge tweaks
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, opacity = "0.0", no_anim = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_initial_focus = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, max_size = {1, 1} })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_blur = true })
hl.window_rule({ match = { class = "^(xwaylandvideobridge)$" }, no_focus = true })

-- Suppress maximize events globally
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix dragging issues for XWayland
-- hl.window_rule({
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })
