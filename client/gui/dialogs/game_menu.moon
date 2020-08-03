----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
log = (require"log")"gameMenu"

main_menu = (screen) ->

    log.debug"game_menu dialog called"

    menu_dlg = (require"shared.gui.dialog")("client.gui.layout.game_menu")

    with menu_dlg
        .resume\onPress(     (event) -> screen"game")
        .preferences\onPress((event) -> screen("preferences", "game_menu"))
        -- .quit\onPress(       (event) -> screen"title")
        .exit\onPress(       (event) -> love.event.quit!)

    return menu_dlg

return main_menu
