----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

menu = require'gui.layout.menu'

layout = {
    -- { id: 'load',        text: 'Load',        status: 'Not Implemented' }
    { id: 'campaign',    text: 'Campaign',    status: 'Start a campaign'}
    -- { id: 'hotseat',     text: 'Hotseat',     status: 'Hotseat / Skirmish'}
    -- { id: 'editor',      text: 'Editor',       status: 'Not Implemented'}
    { id: 'preferences', text: 'Preferences', status: 'Global preferences'}
    -- { id: 'credits',     text: 'Credits',     status: 'Open credits screen'}
    { id: 'exit',        text: 'Exit',        status: 'Return to launcher'}
    { id: 'quit',        text: 'Quit',        status: 'Quit to Desktop'}
}

return menu("localMenu", layout)
