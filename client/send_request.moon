----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
server = love.thread.getChannel( 'server' )

send_request = (request) ->
    server\push(request)

return send_request
