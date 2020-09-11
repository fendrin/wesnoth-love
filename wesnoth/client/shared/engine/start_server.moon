----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love

import quit from require'client.shared.engine'

loging = loging
log    = loging'client'

-- todo handle more gracefully
love.threaderror = (thread, errorstr) ->
    -- thread:getError() will return the same error string now.
    log.error("Thread error!\n"..errorstr)
    quit!


export server = love.thread.newThread("wesnoth/server/main.lua")
server\start!

