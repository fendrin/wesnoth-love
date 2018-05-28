----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- This file is executed by love after "conf.lua".
-- Only those two files are ever sourced by the engine,
-- every other functionallity must be required from here.

-- Calling the "launcher" modules for two reasons,
-- first we continue coding in moonscript,
-- second we do not want to clutter the root folder too much
require"launcher"
