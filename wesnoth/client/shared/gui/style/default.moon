----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


{
    win: {
        padding: 8
        -- margin:
        slices: "assets/themes/wesnoth-highres/submenu.png"
        -- type: 'window'
        -- slices: get.assets"images/dialogs/selection2-background.png"
    }
    toolbar: {
        type: 'panel'
        margin: 0
        padding: 0
        height: 'auto'
        flow: 'x'
    }
    toolButton: {
        type: 'button'
        align: 'center middle'
        -- width: 48
        height: 72
        width: 140
        slices: (self) ->
            if self.focused or self.hovered or self.pressed.left
                return nil -- fall back to theme default

            return false -- no slices
    }

    prefMenu: {
        type: 'panel'
        margin: 0
        padding: 0
        flow: 'y'
        background: {0,0,0}
        height: "auto"
        width: "auto"
        size: 20
        color: {255,255,255}
    }
    prefMenuButton: {
        margin: 0
        type: 'radio'
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
    }


    statusbar: {
        align: 'left middle'
    }
    listThing: {
        align: 'left middle'
        outline: { 0.5, 0.5, 0.5, 0.5 }
        background: { 0.5, 0.5, 0.5, 0.25 }
        height: 120
        padding: 8
        margin: 2
        -- icon = 'icon/32px/Box.png',
        wrap: true
    }
    -- dialog styles
    dialog: {
        type: 'submenu'
        width: 600
        height: 400
    }
    dialogHead: {
        align: 'middle center'
        height: 36
        size: 16
        type: 'panel'
    }
    dialogBody: {
        align: 'left middle'
        -- font = 'font/DejaVuSansMono.ttf',
        background: { 0, 128, 128, 0 }
        padding: 4
        wrap: true
    }
    dialogFoot:
        flow: 'x'
        height: 'auto'
        type: 'panel'
    dialogButton:
        type: 'button'
        width: 140
        height: 45
        color: { 0.734375 * 256, 0.6875 * 256, 0.53125 * 256}
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
        -- align: "right"
        background: { 20, 28, 28, 100 }
        color: { 120, 128, 128 }
        -- outline: { 20, 28, 28, 100 }
        type: "panel"
        width: "auto"
        margin: 30
        padding: 20
        height: "auto"
}
