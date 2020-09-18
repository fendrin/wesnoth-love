----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

connect     = require'screens.connect'
titleLocal  = require'screens.title_local'
preferences = require'screens.ingame_preferences'


{
    :connect
    :titleLocal
    preferences: (director) -> preferences(director, 'titleLocal')
}

