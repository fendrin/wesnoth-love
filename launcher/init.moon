----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
run = require"shared.run_moon"
load = require'launcher.load'

love.load = (arg) ->
    run( -> load(arg))
