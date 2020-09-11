----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- @file This file is executed by love after "conf.lua".
-- Only those two files are ever sourced by the engine,
-- every other functionallity must be required from here.

-- later, we might think about starting the server when asked by the commandline at this point.
-- the alternative is a standalone server, launched without love2d.
require'client'

