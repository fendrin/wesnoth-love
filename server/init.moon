----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

request_handler = require"server.request_handler"

love = love
log  = (require"log")"server"

log.info"Start..."

client = love.thread.getChannel( 'client' )
server = love.thread.getChannel( 'server' )

controller = (require"wesnoth").controller
-- wesnoth    = (require"wesnoth").wesnoth

controller.read_data_tree!

client\push{ command_name: "server_ready" }

-- todo
-- assert(wesnoth.game_config)
-- game_config = wesnoth.game_config
-- game_config.command_name = "gameConfig"
-- client\push(wesnoth.game_config)

log.debug'start serverLoop'
running = true
while running

    request = server\demand!
    answer  = request_handler(request)
    if answer
        for command in *answer
            client\push(command)
