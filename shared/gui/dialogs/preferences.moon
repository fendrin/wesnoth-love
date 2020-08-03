----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love

preferences = (root) ->

    dialog = require"shared.gui.dialog"
    dialog_path = "shared.gui.layout.preferences"
    dialogs = {
        general:     dialog("#{dialog_path}.preferences", "#{dialog_path}.general")
        hotkeys:     dialog("#{dialog_path}.preferences", "#{dialog_path}.hotkeys")
        display:     dialog("#{dialog_path}.preferences", "#{dialog_path}.display")
        sound:       dialog("#{dialog_path}.preferences", "#{dialog_path}.sound")
        multiplayer: dialog("#{dialog_path}.preferences", "#{dialog_path}.multiplayer")
        advanced:    dialog("#{dialog_path}.preferences", "#{dialog_path}.advanced")
    }

    for __, dlg in pairs dialogs
        for pressed, pressed_dlg in pairs dialogs
            dlg[pressed .. "Button"]\onPress((event) ->
                dlg\hide!
                pressed_dlg[pressed .. "Button"]\focus!
                dialogs[pressed]\show!
            )
        dlg.closeButton\onPress((event) ->
            dlg\hide!
            root!
        )

    dialogs.display.displayButton\focus!

    with dialogs.display

        -- @todo handle width and height
        -- width, height, flags = love.window.getMode!
        _, _, flags = love.window.getMode!

        .mode_desktop     = flags.fullscreentype == "desktop"
        .mode_exclusive   = flags.fullscreentype == "exclusive"
        .fullscreen.value = flags.fullscreen

        .fullscreen\onChange((fullscreen) ->
            -- @todo handle outcome
            -- success =
            love.window.setFullscreen( fullscreen.value )
        )

    return dialogs.display


return preferences
