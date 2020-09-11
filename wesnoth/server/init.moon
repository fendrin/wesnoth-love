----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love

export loging  = (require"log")("server")
log = loging"init"

-- request the handler after loging is exported
request_handler = require"request_handler"

log.info"Start..."

client = love.thread.getChannel( 'client' )
server = love.thread.getChannel( 'server' )

controller = (require"wesnoth").controller
controller.read_data_tree!

log.debug'start serverLoop'
while true

    request = server\demand!
    break if request.name == 'disconnect'

    answer  = request_handler(request)
    if answer
        for command in *answer
            client\push(command)

