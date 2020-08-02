----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
stringx  = require"pl.stringx"

load = ( arg ) ->

    love_path = love.filesystem.getRequirePath!
    with package
        paths = {.path, love_path,
            .moonpath, .love_moonpath}

        str = ""
        spacer = '\n * '
        for path in *paths
            str ..= stringx.replace(path, ';', spacer)

        LOG_LUA  = (require"log")"lua"
        LOG_LUA.debug('Search Paths:' .. spacer .. str)


    require"launcher.preferences"
    screen = require"shared.screen"
    screen("splash")

    -- @todo
    -- save_dir = "saves"
    -- unless love.filesystem.getInfo(save_dir)
    --     love.filesystem.createDirectory(save_dir)


    -- @todo
    -- config = (require"launcher.cmd_line")(arg)

return load
