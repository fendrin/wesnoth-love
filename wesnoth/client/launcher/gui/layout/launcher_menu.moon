----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

menu = require'gui.layout.menu'

layout = {
    { id: 'localServer', text: 'Local Game', status:'Connect local Server' }
    -- { id: 'remoteServer', text: 'Remote Game', status:'Connect remote Server' }
    -- { id: 'addon', text: 'Add-ons', status:'Open addon-thread in webbrowser'}
    -- { id: 'language', text: 'Language', status:'Choose your language'}
    { id: 'preferences', text: 'Preferences', status: 'Global Preferences' }
    { id: 'feedback', text: 'Feedback', status:'Open dev-thread in webbrowser'}
    { id: 'quit', text: 'Quit', status: 'Close Wesnoth Launcher'}
}

return menu("launcherMenu", layout)
