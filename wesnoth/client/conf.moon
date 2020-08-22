----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- todo think about getting rid of love here
love = love

-- todo this string is also set in config files, take from there
love.filesystem.setIdentity'wesnoth'
fs = require'client.shared.engine.filesystem'

config = fs.loadConfig!

-- no config file (or not parsable) use the launcher's config
unless config
    love.conf = require'client.launcher.conf'
else -- the game and configurator share the same config
    love.conf = require'client.shared.conf'

