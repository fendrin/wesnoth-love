----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


prestart = require'screens.prestart'
story    = require'screens.story'
game     = require'screens.game'
menu     = require'screens.game_menu'
preferences = require'screens.ingame_preferences'

{
    :prestart
    :story
    :game
    :menu
    preferences: (director) -> preferences(director, 'game')
}

