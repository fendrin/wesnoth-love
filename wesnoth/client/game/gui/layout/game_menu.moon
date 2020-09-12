----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

menu = require'gui.layout.menu'

layout = {
    { id: 'resume', text: 'Resume' }
    -- { id: 'objectives', text: 'Objectives' }
    -- { id: 'stats', text: 'Statistics' }
    -- { id: 'units', text: 'Unit List' }
    -- { id: 'load', text: 'Load' }
    { id: 'preferences', text: 'Preferences' }
    { id: 'exit', text: 'Exit' }
    { id: 'quit', text: 'Quit' }
}

return menu("gameMenu", layout)
