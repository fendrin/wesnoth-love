----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love


return (screen) ->

    handle_command = (command) ->
        switch command.command_name
            when "server_ready"
                require"launcher.start_client"
                return true

        return false


    return {
        open: (story) ->
            love.mouse.setVisible(false)
            require"launcher.start_server"
        close: ->
        update: (dt)->
        :handle_command
        draw: ->
            love.graphics.print("loading ...", 400,400)
        -- @todo implement 'cancel'?
        -- keypressed: (key)->
        --     if key == "escape"
    }
