----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


loging = loging
log    = loging"gui"

menu = (handler) ->

    log.debug"local_menu dialog called"
    dlg = (require"gui.dialog")("gui.layout.local_menu")

    with dlg
        .campaign\onPress(   (event) -> handler"campaign")
        .preferences\onPress((event) -> handler"preferences")
        .quit\onPress(       (event) -> handler"quit")
        .exit\onPress(       (event) -> handler"exit")

    return dlg


return menu

