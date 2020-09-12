----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


preferences = (content) ->

    menu = {style: "prefMenu"
        {id: 'generalButton',     style: 'prefMenuButton'
            icon: "assets/images/icons/icon-general.png"
            text: "General",      status: 'General Game Options' }
        {id: 'hotkeysButton',     style: 'prefMenuButton'
            icon: "assets/images/icons/icon-hotkeys.png"
            text: "Hotkeys",      status: 'Hotkey Bindings' }
        {id: 'displayButton',     style: 'prefMenuButton'
            icon: "assets/images/icons/icon-display.png"
            text: "Display",      status: 'Resolution & Display' }
        {id: 'soundButton',       style: 'prefMenuButton'
            icon: "assets/images/icons/icon-music.png"
            text: "Sound",        status: 'Volume & Music settings' }
        {id: 'multiplayerButton', style: 'prefMenuButton'
            icon: "assets/images/icons/icon-multiplayer.png"
            text: "Multiplayer",  status: 'Multiplayer Preferences' }
        {id: 'advancedButton',    style: 'prefMenuButton'
        --, shortcut: { 'win-z', 'mac-x' }
            icon: "assets/images/icons/icon-advanced.png"
            text: "Advanced",     status: 'Advanced Game Options' }
    }

    return {
        {}
        {flow: 'x', height: "auto", size: 22
            {}
            {slices: "assets/themes/wesnoth/submenu_solid.png"
                height: 720, width: 1280, padding: 18
                {style: 'dialogHead', text: ' Preferences', size: 32,
                    align: "left, middle", height: 44
                    background: {0,0,0,0}
                }
                {flow: 'x', height: "auto"
                    menu, content
                }
                {style: 'dialogFoot', background: {0,0,0,0}
                    height: "auto"
                    {type: 'status', id: 'statusbar', width: false, height: false,
                        color: {255,255,255}, background: {0,0,0,150}, size: 18}
                    {width: 10}
                    { style: 'menuButton', id: 'cancelButton',  text: 'Cancel' }
                    { style: 'menuButton', id: 'confirmButton', text: 'Confirm' }
                }
            }
            {}
        }
        {}
    }

return preferences
