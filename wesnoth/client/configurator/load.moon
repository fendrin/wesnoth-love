 ----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
logger = require"shared.log"


load = ( arg ) ->

    engine = require'client.shared.engine'
    engine.removeConfig!
    engine.deleteLogs
    export loging  = logger("configurator")
    log = loging("load")

    paths = {
        'wesnoth/shared'
        'wesnoth/client'
        'wesnoth/client/shared'
        'wesnoth/client/shared/lib'
        "wesnoth/client/configurator"
        "wesnoth/client/configurator/lib"
        "wesnoth/client/configurator/shared"
        "wesnoth/client/configurator/shared/lib"
    }
    engine.setRequirePath(paths)
    engine.logPathes!

    Director = require'screen.Director'
    screens  = require'screens'
    director = Director(screens)
    -- hook must be called before activate ?
    director\hook!
    director\activate('connect')

    engine.startServer!

    log.debug'load complete'


return load
