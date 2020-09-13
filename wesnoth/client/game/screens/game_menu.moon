----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


engine = require'engine'
Screen = require'screen.Screen'


class MenuScreen extends Screen

    handler = (action) =>
        @next_action = action


    new: (director) =>
        @id = 'menuScreen'
        @background = "maps/background.jpg"
        @foreground = "wesnoth-logo-1920.png"
        @gameMenu   = (require"gui.dialogs.game_menu")((action) -> handler(@, action))
        super(director)


    open: =>
        engine.pointer2dialog(@gameMenu, 'gameMenu')
        super!


    close: =>
        @gameMenu\hide!
        super!


    handle_command: =>
        return false


    update: (dt) =>
        switch @next_action
            when "exit"
                engine.restart!
            when "quit"
                engine.quit(0)
            when "preferences"
                @director\activate"preferences"
            when "resume"
                @director\activate"game"
        @next_action = nil
        super(dt)


    keypressed: (key) =>
        if key == 'escape'
            @director\activate"game"
        -- super(key)


    draw: =>
        engine.drawBackground(@background)
        engine.drawBackground(@foreground)
        super!

