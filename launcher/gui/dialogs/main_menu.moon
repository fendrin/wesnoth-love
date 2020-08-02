----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
log = (require"log")"mainMenu"

start_campaign = require"client.start_campaign"

main_menu = (screen) ->

    log.debug"main_menu dialog called"
    menu_dlg = (require"shared.gui.dialog")("launcher.gui.layout.main_menu")

    with menu_dlg
        -- .tutorial\onPress((event) ->
        --     menu_dlg\hide!
        --     start_campaign("Tutorial")
        --     screen("load")
        -- )
        .demo\onPress((event) ->
            menu_dlg\hide!
            -- start_campaign("An_Orcish_Incursion")
            screen("load")
        )
        -- .preferences\onPress((event) ->
        --     screen("prefs", "title")
        -- )

        menu_dlg.quit\onPress((event) -> love.event.quit! )

    return menu_dlg

return main_menu
