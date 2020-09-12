----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

Screen = require'screen.Screen'

prefs = require'client.shared.preferences'

class Preferences extends Screen

    handler: (item, value) =>
        switch item
            when 'close'
                if value
                    prefs.save!
                else
                    prefs.reload!
                @director\activate(@parent)
            when 'fullscreen'
                prefs.setFullscreen(value)

    new: (director, parent) =>
        @prefs = (require"gui.dialogs.preferences")(
            (item, value) -> @\handler(item, value))
        @parent = parent
        super(director)


    keypressed: (key) =>
        if key == 'escape'
            prefs.reload!
            @director\activate(@parent)


    open: =>

        @prefs.display.fullscreen.value = prefs.getFullscreen!

        @prefs.display\show!


    close: =>

