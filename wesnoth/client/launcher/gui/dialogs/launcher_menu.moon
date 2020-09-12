----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
loging = loging
log    = loging"gui"

menu = (handler) ->

    log.debug"main_menu dialog called"
    dlg = (require"gui.dialog")("gui.layout.launcher_menu")

    with dlg
        .localServer\onPress((event) ->
            dlg\hide!
            handler("local")
        )
        .feedback\onPress((event) ->
            handler('feedback')
        )
        -- .addon\onPress((event) ->
        --     handler('addon')
        -- )
        .preferences\onPress((event) ->
            dlg\hide!
            handler("preferences")
        )
        .quit\onPress((event) ->
            dlg\hide!
            handler("quit")
        )

    return dlg


return menu
