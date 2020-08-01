----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

Preferences = Preferences
Layout = require"client.lib.luigi.luigi.layout"
log = (require"log")"YesNoDLG"

yes_no = (header, text, handler) ->

    log.debug"yes_no dialog called"
    layout_cfg = require"client.gui.layout.yes_no"(header, text)
    dlg = Layout(layout_cfg)
    with dlg
        dlg\setStyle(require"client.gui.style.#{Preferences.style}")
        dlg\setTheme(require"client.gui.theme.#{Preferences.theme}")
        .yesButton\onPress( (event) ->
            dlg\hide!
            handler(true) )
        .noButton\onPress(  (event) ->
            dlg\hide!
            handler(false) )

    return dlg

return yes_no
