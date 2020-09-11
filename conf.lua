----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


----
-- Executed by the love2d engine before all other files.
-- used to configure the moonscript search pathes and loading moonscript.
-- At last we register our config function here which is later called for
-- seting up the engine's parameters.


-- this is the bare minimum to load the next file
local shared_path = {
    "wesnoth",
    "wesnoth/shared",
    "wesnoth/shared/lib",
    "wesnoth/shared/lib/moonscript",
    "wesnoth/shared/lib/Penlight/lua"
}
local setRequirePath = require'wesnoth.shared.setRequirePath'
setRequirePath(shared_path)

-- First set the lua searchpath of love to our needs, then require moonscript,
-- which registers its own loader (for files with the .moon extension)
-- with the luapathes rewriten for moonscript.
require"moonscript"

-- Register the love.conf function after requireing moonscript,
-- since the function's file could already miss a lua counterpart.
require"client.conf"
