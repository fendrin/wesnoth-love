----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
log = (require"log")"gameMenu"

game_menu = (handler) ->

    log.debug"game_menu dialog called"

    menu_dlg = (require"shared.gui.dialog")("client.gui.layout.game_menu")

    with menu_dlg
        .resume\onPress(     (event) -> handler"resume")
        .preferences\onPress((event) -> handler"preferences")
        .quit\onPress(       (event) -> handler"quit")
        .exit\onPress(       (event) -> handler"exit")

    return menu_dlg

return game_menu
