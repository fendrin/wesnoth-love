----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
command_handler = require"client.command_handler"

return (screen) ->

    open = () ->
    close = ->
    update = () ->
    draw = () ->

    keypressed = (k) ->
        -- todo this gives us an error:
        -- Error: [string "boot.lua"]:302: Failed to initialize filesystem: already initialized
        -- if k == 'f5'
        --     love.event.quit('restart')
        if k == 'escape'
            screen("title")

    handle_command = (command) ->
        command_handler(command, screen)

    return {
        :handle_command
        :keypressed
        :update
        :open
        :close
        :draw
    }

