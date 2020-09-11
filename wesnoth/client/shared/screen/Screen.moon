----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love
loging = loging
log  = loging"screen"

engine = require'engine'
Moan = require'Moan'


class Screen

    new: (director) =>
        @moan = Moan!
        @director = director
        -- @id = 'id unset'


    open: () =>
        log.debug"Screen Open: #{@id}"


    close: () =>
        log.debug"Screen Closed: #{@id}"


    update: (dt) =>
        -- @moan\update(dt)
        if command = engine\pop!
            log.debug"#{@id} Handle Command: #{command.command_name}"

            if @handle_command(command)
                log.debug"Command #{command.command_name} handled by #{@id} active_screen."
            else
                log.warn"#{@id} unhandled command #{command.command_name}"


    draw: =>
        -- @moan\draw!
        engine.drawPerformance!

