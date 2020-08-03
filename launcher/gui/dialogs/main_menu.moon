----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
log = (require"log")"mainMenu"

main_menu = (handler) ->

    log.debug"main_menu dialog called"
    menu_dlg = (require"shared.gui.dialog")("launcher.gui.layout.main_menu")

    with menu_dlg
        .demo\onPress((event) ->
            menu_dlg\hide!
            handler("demo")
        )
        .preferences\onPress((event) ->
            menu_dlg\hide!
            handler("preferences")
        )
        .quit\onPress((event) ->
            menu_dlg\hide!
            handler("quit")
        )

    return menu_dlg

return main_menu
