----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

Layout = require"client.lib.luigi.luigi.layout"
Preferences = Preferences


dialog = (layout, sublayout) ->

    local dlg
    if sublayout
        layout_cfg = require(layout)
        sublayout_cfg = require(sublayout)
        dlg = Layout(layout_cfg(sublayout_cfg))
    else
        dlg = Layout(require(layout))

    dlg\setStyle(require"shared.gui.style.#{Preferences.style}")
    dlg\setTheme(require"shared.gui.theme.#{Preferences.theme}")

    return dlg


return dialog
