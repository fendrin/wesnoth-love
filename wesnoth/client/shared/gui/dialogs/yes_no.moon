----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


loging = loging
log = loging"gui"

dialog = require'gui.dialog'


yes_no = (header, text, handler) ->

    log.debug"yes_no dialog called"
    layout_cfg = require"gui.layout.yes_no"(header, text)

    dlg = dialog(layout_cfg)
    with dlg
        .yesButton\onPress( (event) ->
            dlg\hide!
            handler(true) )
        .noButton\onPress(  (event) ->
            dlg\hide!
            handler(false) )

    return dlg

return yes_no
