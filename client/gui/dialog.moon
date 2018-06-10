----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

Layout = require"client.lib.luigi.luigi.layout"
Preferences = Preferences


dialog = (layout, sublayout) ->

    local dlg
    if sublayout
        dlg = Layout(
            (require"client.gui.layout.#{layout}")(
                require"client.gui.layout.#{sublayout}"))
    else
        dlg = Layout(require"client.gui.layout.#{layout}")

    dlg\setStyle(require"client.gui.style.#{Preferences.style}")
    dlg\setTheme(require"client.gui.theme.#{Preferences.theme}")

    return dlg


return dialog
