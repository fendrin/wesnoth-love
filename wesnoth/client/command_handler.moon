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

        when 'show_objectives'
            cfg = {
                message: command.objectives
            }
            director.screens.game.moan\speak(cfg)
            return true

        when "setupReady"
            engine.sendRequest{ request_name: "startScenario" }
            return true

        when "data"
            export DATA = command
            return true

        when 'state'
            gameState.board.map = command.board.map
            for unit in *command.board.units
                gameState.board.units\place_unit(unit,
                    unit.x, unit.y)
            return true

        -- when "Music"
        --     music.add_to_playlist(
        --         "assets/data/core/music/#{command.name}")
        --     return true

        else
            return false


return handle_command

