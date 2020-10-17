----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love

send_command = (command) ->
    client = love.thread.getChannel'client'
    client\push(command)


return send_command

