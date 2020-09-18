----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- todo get rid of love
love = love
loging = loging
log = loging"client"

engine = require'engine'
send_request = require'send_request'
o_ten_one = require'splashes.o-ten-one'
Screen = require'screen.Screen'

cfg = {
    -- fill: 'lighten'
    -- fill: 'rain'
    background:   {0,0,0}
    -- delay_after:  8
    -- delay_before: 0.5
}


class Connect extends Screen

    handle_command: (command) =>
        switch command.command_name
            when "data"
                log.info"server data recieved"
                @config_recieved = true
                export DATA = command
                return true

        return false


    new: (director) =>
        super(director)
        @splash_done = false
        @config_recieved = false


    open: =>
        @splash = o_ten_one.new(cfg)
        @splash.onDone = ->
            @splash_done = true
            love.graphics.reset!
        engine.play"assets/sounds/love_short.ogg"

        love.mouse.setVisible(false)

        connect = {
            request_name: 'connect'
        }

        send_request(connect)


    update: (dt) =>
        super!
        @splash\update(dt/2.75)

        if @splash_done and @config_recieved
            @splash_done = false
            love.graphics.reset!
            @director\activate('titleLocal')


    draw: =>
        unless @splash_done
            @splash\draw!
        unless @config_recieved
            love.graphics.print("connecting Server - press esc to cancel...", 400,400)
        else
            love.graphics.print("Server Ready - press the any key to continue...", 400,400)


    skip_splash = () =>
        if ( not @splash_done and @config_recieved )
            @splash\skip!


    mousepressed: (x, y, button, istouch, presses) =>
        skip_splash(@)


    keypressed: (key) =>
        if key == "escape"
            engine.restart!
        else
            skip_splash(@)

