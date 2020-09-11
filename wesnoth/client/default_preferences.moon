----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


{
    -- love config values, same id
    window:
        width:  1920
        height: 1080

        fullscreen:     true
        fullscreentype: 'desktop'

        vsync: 1

    modules:
        audio: true
        -- note: sound is for decoding
        sound: true

    -- wesnoth related preferences
    audio:
        volume:
            master:    1.0
            music:     1.0
            effects:   1.0
            interface: 1.0
            turnBell:  1.0
        pauseOnFocusLost: true

    general:
        scrollSpeed: 1.0

    display:
        gui:
            theme: 'wesnoth-highres'
            style: 'default'
}

