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

        LOG_LUA  = (require"shared.log")"lua"
        LOG_LUA.debug('Search Paths:' .. spacer .. str)


    -- @todo
    -- save_dir = "saves"
    -- unless love.filesystem.getInfo(save_dir)
    --     love.filesystem.createDirectory(save_dir)

    -- @todo
    -- LOG_PREF = (require"shared.log")"preferences"
    export Preferences = {
        theme: "wesnoth-highres"
        style: "default"
    }
    -- preferences_file = "preferences.moon"
    -- if love.filesystem.getInfo(preferences_file)
    --     LOG_PREF.info"Preferences file found"
    -- else
    --     LOG_PREF.info"Preferences file *not* found"

    -- @todo
    -- config = (require"launcher.cmd_line")(arg)

    love.threaderror = (thread, errorstr) ->
        -- thread:getError() will return the same error string now.
        print("Thread error!\n"..errorstr)

    thread = love.thread.newThread("server/main.lua")
    thread\start!

    screenID = "splash"
    screenID = "load"
    screen = require"client.screen"
    screen(screenID)


return load
