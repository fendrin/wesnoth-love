----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


{
    toolbar:
        type: 'panel'
        margin: 0
        padding: 0
        height: 'auto'
        flow: 'x'

    toolButton:
        type: 'button'
        align: 'center middle'
        height: 72
        width: 140
        slices: (self) ->
            if self.focused or self.hovered or self.pressed.left
                return nil -- fall back to theme default

            return false -- no slices

    statusbar:
        align: 'left middle'

    listThing:
        align: 'left middle'
        outline: { 0.5, 0.5, 0.5, 0.5 }
        background: { 0.5, 0.5, 0.5, 0.25 }
        height: 120
        padding: 8
        margin: 2
        wrap: true

    -- dialog styles
    dialog:
        padding: 8
        type: 'submenu'
        width: 600
        height: 400

    dialogHead:
        align: 'middle center'
        height: 36
        size: 16
        type: 'panel'

    dialogBody:
        type: 'panel'
        align: 'left middle'
        padding: 24
        wrap: true
        size: 16

    dialogFoot:
        flow: 'x'
        height: 'auto'
        type: 'panel'
    dialogButton:
        align: 'center middle'
        type: 'button'
        width: 140
        height: 45
        color: { 0.734375, 0.6875, 0.53125 }
        size: 18
----------------------------------------------------------------------------
    titleScreen:
        type: "window"
    menuButton:
        align: 'center middle'
        type: 'button'
        width: 160
        height: 50
        size: 20
        color: { 0.734375, 0.6875, 0.53125 }
    transparent_panel:
        align: 'center middle'
        background: { 20/255, 28/255, 28/255, 100/255 }
        type: "panel"
        width: "auto"
        margin: 30
        padding: 20
        height: "auto"
    prefMenu:
        type: 'panel'
        margin: 0
        padding: 0
        flow: 'y'
        background: {0,0,0}
        height: "auto"
        width: "auto"
        size: 20
        color: {255,255,255}
    prefMenuButton:
        margin: 0
        type:  'radio'
        group: 'prefMenu'
        align: 'left, middle'
        minheight: 95
        width: 220
        slices: (self) ->
            if self.focused
                return "assets/images/dialogs/selection2-background.png"
            if self.value
                return "assets/images/dialogs/selection-background.png"

            if self.focused or self.hovered or self.pressed.left
                return nil -- fall back to theme default

            return false -- no slices
    win:
        padding: 8
        slices: "assets/themes/wesnoth-highres/submenu.png"

}

