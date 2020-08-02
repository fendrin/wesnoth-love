----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


send_request = require"client.send_request"
moan  = require"client.screens.game.moan"

handle_command = (command, screen) ->
    gameState = gameState
    switch command.command_name
        when "story"
            screen("story", command)
            return true
        when "message"
            moan.handle_command(command)
            return true
        when "map"
            gameState.board.map = command
            return true
        when "setupReady"
            send_request{
                request_name: "startScenario"
            }
            return true
        -- when "Side"
        --     gameState.board.sides[command.side] = command
        --     return true
        when "Units"
            for unit in *command.units
                gameState.board.units\place_unit(unit,
                    unit.x, unit.y)
            return true
        -- when "Music"
        --     music.add_to_playlist(
        --         "assets/data/core/music/#{command.name}")
        --     return true
        -- when "gameConfig"
        --     gameState.gameConfig = command
        --     screen("title")
        --     return true
        else
            return false

    assert(false)

return handle_command
