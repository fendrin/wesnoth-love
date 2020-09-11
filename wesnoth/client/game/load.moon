 ----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

logger = require'shared.log'


load = ( arg ) ->

    engine = require'client.shared.engine'
    engine.deleteLogs
    export loging = logger'configurator'
    log = loging'load'

    paths = {
        'wesnoth/shared'
        "wesnoth/shared/lib/moonscript"
        'wesnoth/client'
        'wesnoth/client/shared'
        'wesnoth/client/shared/lib'
        'wesnoth/client/game'
        'wesnoth/client/game/lib'
        'wesnoth/client/game/shared'
        'wesnoth/client/game/shared/lib'
    }
    engine.setRequirePath(paths)
    engine.logPathes!

    Director = require'screen.Director'
    screens  = require'screens'
    director = Director(screens)
    -- hook must be called before activate ?
    director\hook!
    director\activate'prestart'

    engine.startServer!
    log.debug'load complete'


return load

