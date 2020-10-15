----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love

game_screen = (handler) ->

    dlg = (require"gui.dialog")("gui.layout.game_screen")
    with dlg
        .menuButton\onPress( (event) -> handler"menu" )
        .todImg\onPress(     (event) -> handler"endTurn" )
        .flag\onPress(       (event) -> handler"objectives" )

    return dlg


return game_screen

