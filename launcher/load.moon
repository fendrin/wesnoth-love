----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

log  = (require"log")"load"
love = love
fs   = love.filesystem
stringx = require"pl.stringx"


search_path = () ->
    love_path = fs.getRequirePath!
    spacer = '\n * '
    searchpath = 'Search Paths:' .. spacer
    with package
        paths = {.path, love_path, .moonpath, .love_moonpath}
        for path in *paths
            searchpath ..= stringx.replace(path, ';', spacer)
    return searchpath


load = ( arg ) ->

    -- todo mv logger setup into log.set_config
    config = (require"launcher.cmd_line")(arg)
    if log_domain = config.debug
        log.warn"enabling debug output for #{log_domain}"
        log_config = {
            [log_domain]: true
        }
        log.set_config(log_config)

    save_dir = fs.getSaveDirectory!

    with log
        .info("Working Directory:" .. fs.getWorkingDirectory!)
        .info("User Directory: " .. fs.getUserDirectory!)
        .info("Appdata Directory: " .. fs.getAppdataDirectory!)
        .info"Save Directory: #{save_dir}"
        .debug(search_path!)
        .info"C Require Path: #{fs.getCRequirePath!}"

    -- @todo
    -- save_dir = "saves"
    -- unless love.filesystem.getInfo(save_dir)
    --     love.filesystem.createDirectory(save_dir)

    require"launcher.preferences"
    screen = require"shared.screen"
    screen("splash")


return load
