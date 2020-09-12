----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love

preferences = (handler) ->

    dialog = require"gui.dialog"
    dialog_path = "gui.layout.preferences"

    subdialogs = {'general', 'hotkeys', 'display', 'sound', 'multiplayer', 'advanced'}
    dialogs = {}
    for subdialog in *subdialogs
        dialogs[subdialog] = dialog( require"#{dialog_path}.preferences"( require"#{dialog_path}.#{subdialog}"))

    for __, dlg in pairs dialogs
        for pressed, pressed_dlg in pairs dialogs
            dlg[pressed .. "Button"]\onPress((event) ->
                dlg\hide!
                pressed_dlg[pressed .. "Button"]\focus!
                dialogs[pressed]\show!
            )
        dlg.confirmButton\onPress((event) ->
            dlg\hide!
            handler("close", true)
        )
        dlg.cancelButton\onPress((event) ->
            dlg\hide!
            handler("close", false)
        )

    dialogs.display.displayButton\focus!

    with dialogs.display
        .fullscreen\onChange((fullscreen) ->
            handler("fullscreen", .fullscreen.value))
        .fullscreentype\onChange((widget) ->
            handler("fullscreentype", .fullscreentype.selected.id))

    -- with dialogs.sound


    return dialogs


return preferences
