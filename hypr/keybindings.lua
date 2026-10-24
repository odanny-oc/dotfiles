-------------------
---- INPUT ----
-------------------
-- Converted from keybindings.conf
-- https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
    input = {
        -- TODO: `emulate_discrete_scroll = 0` - left as 0 (int) to match the old
        -- value; if the Lua config wants a real boolean here, use `false` instead.
        emulate_discrete_scroll = 0,
        -- accel_profile = "flat",
        kb_layout = "gb, es, gr, fr",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        numlock_by_default = true,

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        tablet = {
            output = "eDP-1",
            -- region_size = "1870 900",
            relative_input = false,
        },
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
        touchdevice = {
            transform = 0,
            output = "eDP-1",
            enabled = true,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- hl.gesture({ fingers = 3, direction = "vertical", action = function()
--     hl.exec_cmd("kill -34 $(ps -C wvkbd-deskintl)")
-- end })

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name = "unknown-device",
    sensitivity = -0.5,
})

hl.device({
    name = "ydotoold-virtual-device-1",
    accel_profile = "flat",
    kb_layout = "uk",
    kb_variant = "",
    kb_options = "",
})

---------------------
---- KEYBINDINGS ----
---------------------
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

local terminal    = "ghostty"
local fileManager  = "dolphin"
local menu         = "wofi -n --show drun"
local browser      = "firefox"
local editor        = "nvim"
local scrPath       = os.getenv("HOME") .. "/.config/hypr/scripts"
local iconsPath      = os.getenv("HOME") .. "/.config/icons"

-- TODO(hyprgrass): these two lines used the `hyprgrass-bind` / `hyprgrass-bindm`
-- keywords from the hyprgrass touch-gesture plugin. Plugins that haven't been
-- updated for the Lua config may still expect their old hyprlang-style keys to
-- be set via `hyprctl keyword`, or may expose their own hl.* bindings - check
-- the hyprgrass repo/wiki for whatever it currently supports post-0.55.
-- hyprgrass-bind = , edge:d:u, exec, kill -34 $(ps -C wvkbd-deskintl)
-- hyprgrass-bindm = , longpress:2, movewindow

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- hl.bind("F10", hl.dsp.pass({ class = "^(discord)" }))

hl.bind("SHIFT + ALT + K", hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh")) -- switch keyboard layout
hl.bind("SHIFT + ALT + T", hl.dsp.exec_cmd(scrPath .. "/toggle-touch.sh")) -- switch keyboard layout

hl.bind("CTRL + F8", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/xremap/movement_scripts/white.sh"))
hl.bind("CTRL + F9", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/xremap/movement_scripts/red.sh"))
hl.bind("CTRL + F10", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/xremap/movement_scripts/yellow.sh"))

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(terminal .. " -e ssh -XC archpcts"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(scrPath .. "/disable_while_typing.sh"))
-- TODO(combo-key): `Shift_L&Control_L` used hyprlang's "&" combined-key syntax
-- (trigger only when both physical keys are held, independent of "modifier"
-- semantics). Verify whether the Lua bind string still accepts "&" the same
-- way, or whether it now wants " + " like every other combo.
hl.bind("SHIFT_L + CONTROL_L + Escape", hl.dsp.exec_cmd("gnome-system-monitor")) -- TODO: verify combo syntax, see above
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("elecwhat"))
hl.bind("CTRL + ALT + K", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/wvb_keyboard.sh"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("sioyek"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("rnote"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("Spotify"))
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
-- TODO(fullscreen): guessed dispatcher name/shape (hl.dsp.window.fullscreen)
-- by analogy with hl.dsp.window.float() - the wiki example didn't show the
-- fullscreen dispatcher directly, so double check against the Dispatchers page.
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" })) -- TODO: verify against wiki
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(scrPath .. "/waybarrs.sh"))
hl.bind(mainMod .. " + up", hl.dsp.exec_cmd(scrPath .. "/reset_screen_waybar.sh"))
hl.bind(mainMod .. " + right", hl.dsp.exec_cmd(scrPath .. "/rotate_screen_waybar.sh"))
hl.bind("CTRL + ALT + S", hl.dsp.exec_cmd(scrPath .. "/sunshine_headless_monitor.sh"))
-- TODO: the original `bind = Control_L, Return, exec,` had no command after
-- `exec,` - that's a no-op in the old config too, kept as-is.
hl.bind("CTRL + Return", function() end)

-- hl.bind("SHIFT + ALT + L", hl.dsp.exec_cmd("systemctl --user start lan-mouse"))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd(
    'hyprshade off && grimblast copy area && notify-send -i "' .. iconsPath ..
    '/screenshot.png" -e -t 2000 --replace-id=8 "Selected area copied to buffer" && hyprshade auto'
))
-- hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(
--     'hyprshade off && grimblast copy active && notify-send -i "' .. iconsPath ..
--     '/screenshot.png" -e "Selected window copied to buffer" && hyprshade auto'
-- ))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(scrPath .. "/toggle_monitor.sh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshade off && grimblast --notify copysave active && hyprshade auto"))

hl.bind("CTRL + SHIFT + P", hl.dsp.window.pseudo()) -- dwindle
-- hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit")) -- dwindle

-- Move focus with mainMod + arrow keys
-- hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
-- hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
-- hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
-- hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- kept exactly as in the original: L->left, H->right, K->up, J->down
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- TODO(resizeactive): guessed shape for the "resize active window by delta"
-- dispatcher based on the general {direction/delta}-table pattern used
-- elsewhere in the Lua API - the wiki search results didn't surface this one
-- directly, so verify the field name (`delta` vs positional args) against
-- hl.dsp on your installed version.
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({x=30, y = 0, relative=true}))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({x=-30, y = 0, relative=true}))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({x=0, y = 30, relative=true}))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({x=0, y = -30, relative=true}))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
-- (the original had `bindm = $mainMod, mouse:272, movewindow` twice - deduped here)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + Z", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + X", hl.dsp.window.resize(), { mouse = true })

-- TODO(binde-block): the original had a commented-out block using `binde` +
-- a `$moveactivewindow` shell one-liner (checks if the active window is
-- floating via `hyprctl activewindow -j` + jq, and either moves it or calls
-- movewindow). It was disabled in the source file, so it's kept disabled/as
-- a note here rather than guessed at - if you want it, it'll need `binde`'s
-- "repeat while held" behavior, which corresponds to { repeating = true }.
--
-- local moveactivewindow = 'grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive'
-- hl.bind(mainMod .. " + SHIFT + CONTROL + left", hl.dsp.exec_cmd(moveactivewindow .. " -30 0 || hyprctl dispatch movewindow l"), { repeating = true })
-- hl.bind(mainMod .. " + SHIFT + CONTROL + right", hl.dsp.exec_cmd(moveactivewindow .. " 30 0 || hyprctl dispatch movewindow r"), { repeating = true })
-- hl.bind(mainMod .. " + SHIFT + CONTROL + up", hl.dsp.exec_cmd(moveactivewindow .. " 0 -30 || hyprctl dispatch movewindow u"), { repeating = true })
-- hl.bind(mainMod .. " + SHIFT + CONTROL + down", hl.dsp.exec_cmd(moveactivewindow .. " 0 30 || hyprctl dispatch movewindow d"), { repeating = true })

-- Laptop multimedia keys for volume and LCD brightness
-- bindel = locked + repeating
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/volume_down.sh"), { locked = true, repeating = true })
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/volume_up.sh"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/volume_down.sh"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/volume_up.sh"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/volume_mute.sh"), { locked = true, repeating = true })
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/volume_mute.sh"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/brightness_up.sh"), { locked = true, repeating = true })
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/brightness_down.sh"), { locked = true, repeating = true })
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/brightness_up.sh"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/brightness_down.sh"), { locked = true, repeating = true })

-- Requires playerctl
-- bindl = locked only
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("F10", hl.dsp.exec_cmd(
    'playerctl previous && notify-send -i "' ..
    iconsPath .. '/previous.png" -e -t 1300 " Previous"'
), { locked = true })

hl.bind("F11", hl.dsp.exec_cmd(
    'playerctl play-pause && notify-send -i "' ..
    iconsPath .. '/play_pause.png" -e -t 1300 " Play/Pause"'
), { locked = true })

hl.bind("F12", hl.dsp.exec_cmd(
    'playerctl next && notify-send -i "' ..
    iconsPath .. '/skip.png" -e -t 1300 " Next"'
), { locked = true })
