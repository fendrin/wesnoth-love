----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

Layout = require"luigi.luigi.layout"

pref = require'preferences'


decorade = (dlg) ->
    dlg\setStyle(require"gui.style.#{pref.getStyle!}")
    dlg\setTheme(require"gui.theme.#{pref.getTheme!}")


dialog = (layout) ->
    if type(layout) == 'string'
        layout = require(layout)

    dlg = Layout(layout)
    decorade(dlg)
    return dlg


return dialog
