----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- loging = loging
-- log    = loging"screen"


engine = require'engine'
Screen = require'screen.Screen'
command_handler = require'command_handler'
send_request = require'send_request'

class GameScreen extends Screen

    dlg_handler = (action) =>
        unless @moan\showing!
            switch action
                when "menu"
                    @show_menu = true
                when "endTurn"
                    @end_turn  = true
                when 'objectives'
                    @show_objectives = true


    end_turn_confirmed = false
    end_turn_dlg_handler = (confirmed) ->
        end_turn_confirmed = confirmed

    new: (director) =>
        @dlg   = (require"gui.dialogs.game_screen")((action) -> dlg_handler(@, action))
        @board =  require"screens.game.board"
        @end_turn  = false
        @end_turn_dlg = (require"gui.dialogs.yes_no")("End Turn",
                "Do you want to end your turn?", end_turn_dlg_handler)
        @show_menu = false
        @id = 'gameScreen'
        super(director)


    open: =>
        @board.setup(@dlg)

        engine.setCursorVisible( true )
        @resize(engine.getDimensions!)
        @dlg\show!


    close: => @dlg\hide!


    handle_command: (command) =>
        return command_handler(command, @director)


    update: (dt) =>
        super(dt)

        if @show_menu
            @show_menu = false
            @director\activate'menu'

        if @end_turn
            @end_turn = false
            @end_turn_dlg\show!

        if @moan\showing!
            engine.setCursorVisible( false )
            @moan\update(dt)
        else
            engine.setCursorVisible( true )
            @board.update(@dlg, dt)

        if @show_objectives
            @show_objectives = false
            send_request{
                request_name: 'objectives'
            }

        if end_turn_confirmed
            end_turn_confirmed = false
            send_request{
                request_name: 'endTurn'
            }


    draw: =>
        @board.draw(@dlg)
        @moan\draw!
        super!


    -- @todo
    -- local mouse_restore_x, mouse_restore_y
    mousepressed: (x, y, button, istouch) =>
        if @moan\showing!
            switch button
                when 1
                    @moan\advanceMsg!
                when 2
                    @moan\clear!
                when 5
                    @moan\next!
                when 4
                    @moan\previous!
            return true
        else
            return @board.mousepressed(@dlg, x, y, button, istouch)


    mousereleased: ( x, y, button, istouch ) =>
        if button == 3
            -- todo get rid of love
            love.mouse.setRelativeMode(false)
            -- @todo
            -- love.mouse.setPosition(mouse_restore_x, mouse_restore_y)


    keypressed: (key) =>
        print key
        if @moan\showing!
            switch key
                when 'left'
                    @moan\previous!
                when 'right'
                    @moan\next!
                when 'return'
                    print 'return'
                    @moan\clear!
                when 'space'
                    @moan\advanceMsg!
        else
            switch key
                when 'escape'
                    @director\activate'menu'
                when 'm'
                    @director\activate'miniMap'


    ----
    -- @return bool wheter or not the game is to be terminated.
    -- quit = ->
    --     dlg = (require"client.gui.dialogs.yes_no")(
    --         "Do you want to quit the game?")
    --     ret = dlg.show!
    --     if ret
    --         log.info"Thanks for playing. Please play again soon!"
    --         return true
    --     else
    --         return false


    resize: (w, h) =>
        @moan\resize(@dlg.gameMap\getWidth! + 4, @dlg.gameMap\getHeight!)
        @board.resize(w, h)


    mousemoved: (...) =>
        unless @moan\showing!
            @board.mousemoved(@dlg, ...)

