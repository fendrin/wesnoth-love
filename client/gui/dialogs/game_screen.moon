----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love

game_screen = ->

    dlg = (require"client.gui.dialog")("game_screen")
    return dlg

return game_screen
