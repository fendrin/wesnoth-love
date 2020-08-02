----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love

game_screen = ->

    dlg = (require"shared.gui.dialog")("client.gui.layout.game_screen")
    return dlg

return game_screen
