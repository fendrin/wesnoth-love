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
    -- @todo
    -- save_dir = "saves"
    -- unless love.filesystem.getInfo(save_dir)
    --     love.filesystem.createDirectory(save_dir)


    -- @todo
    -- config = (require"launcher.cmd_line")(arg)

    love.threaderror = (thread, errorstr) ->
        -- thread:getError() will return the same error string now.
        print("Thread error!\n"..errorstr)

    thread = love.thread.newThread("server/main.lua")
    thread\start!

    require"client"


return load
