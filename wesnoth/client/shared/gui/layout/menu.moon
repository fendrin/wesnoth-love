----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

greet_txt = 'Welcome to Wesnoth for Löve'
alpha = 0.55
background = {0, 0, 0, alpha}

(id, buttons) -> {
    type: "window"
    flow: 'x'
    status: greet_txt
    {},{},{}
    {
        flow: 'y'
        {
            :background
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
                width:  "auto"
                height: "auto"
                padding: 8
                {
                    status: ''
                    padding: 8
                    :background
                    for button in *buttons
                        { style: 'menuButton', id: button.id,
                            text: button.text, status: button.status }
                        }
                }
            {}
            {}
        }
    }
}

