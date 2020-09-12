----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
logger = require"shared.log"


load = ( arg ) ->

    engine = require'client.shared.engine'
    engine.deleteLogs
    export loging  = logger("launcher")
    log = loging("load")

    paths = {
        -- 'wesnoth'
        'wesnoth/shared'
        'wesnoth/shared/lib'
        'wesnoth/client'
        'wesnoth/client/shared'
        'wesnoth/client/shared/lib'
        "wesnoth/client/launcher"
        "wesnoth/client/launcher/lib"
    }
    engine.setRequirePath(paths)
    engine.logPathes!

    Director = require"screen.Director"
    screens  = require"screens"
    director = Director(screens)
    -- hook must be called before activate
    director\hook!
    director\activate('launcher')

    log.debug'load complete'


return load
