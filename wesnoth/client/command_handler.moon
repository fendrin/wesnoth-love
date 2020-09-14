----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- export gameConfig

-- send_request = require"client.send_request"
-- moan  = require"client.game.screens.game.moan"
engine = require'engine'


handle_command = (command, director) ->
    gameState = gameState
    switch command.command_name

        when "story"
            director.screens.story\showStory(command)
            director\activate"story"
            return true

        when "message"
            director.screens.game.moan\speak(command)
            return true

        when "map"
            gameState.board.map = command
            return true

        when "setupReady"
            engine.sendRequest{ request_name: "startScenario" }
            return true

        when "data"
            -- print'data recieved'
            export DATA = command
            -- moon = require'moon'
            -- moon.p(DATA)
            return true

        when "Units"
            for unit in *command.units
                gameState.board.units\place_unit(unit,
                    unit.x, unit.y)
            return true

        -- when "Music"
        --     music.add_to_playlist(
        --         "assets/data/core/music/#{command.name}")
        --     return true
        else
            return false

    -- assert(false)


return handle_command
