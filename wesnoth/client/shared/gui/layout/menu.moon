----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


greet_txt = 'Welcome to Wesnoth for Löve'

(id, buttons) -> {
    type: "window"
    flow: 'x'
    status: greet_txt
    {},{},{}
    {
        flow: 'y'
        {
            background: {0, 0, 0, 120}
            type: 'status'
            text: greet_txt
            height: 30
            size: 16
            width: 320
        }
        {
            flow: 'y'
            {}
            {
                :id
                status: ""
                slices: "assets/themes/wesnoth-highres/submenu.png"
                background: {0.9, 0.9, 0.9, 160}
                width:  "auto"
                height: "auto"
                padding: 18
                margin:  -3
                for button in *buttons
                    { style: 'menuButton', id: button.id, text: button.text, status: button.status }
            }
            {}
            {}
        }
    }
}

