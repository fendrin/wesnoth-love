----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


command_handler = require"command_handler"
engine  = require'client.shared.engine'
Screen  = require'screen.Screen'
UnitMap = require'unit_map'


class Prestart extends Screen

    new: (director) =>
        @id = 'prestart'
        super(director)


    open: =>

        export gameState = {
            board:
                units: UnitMap(30, 30)
        }

        config = engine.loadConfig!
        engine.removeConfig!

        request = {
            request_name: "startCampaign"
            id: config.campaign
        }
        engine.sendRequest(request)


    keypressed: (key) =>
        if key == 'escape'
            engine.restart!


    handle_command: (command) =>
        return command_handler(command, @director)

