----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


local paths = {
    -- './',
    'wesnoth/shared',
    'wesnoth/shared/lib',
    'wesnoth/shared/lib/moonscript',
    "wesnoth/shared/lib/Penlight/lua",
    'wesnoth/server',
    'wesnoth/server/lib',
    'wesnoth/server/lib/wesnoth',
    'wesnoth/server/lib/wesnoth/utils'
}
local setRequirePath = require'setRequirePath'
setRequirePath(paths)

require"moonscript"
local run = require"run_moon"
local function run_server ()
    require"init"
end
run(run_server)
