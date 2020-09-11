----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

launcher    = require'screens.launcher'
preferences = require'shared.screens.preferences'

{
    :launcher
    preferences: (director) -> preferences(director, 'launcher')
}
