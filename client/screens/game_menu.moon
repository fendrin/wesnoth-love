----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
local gameMenu

update = (dt) ->
draw = ->

open = ->
    love.mouse.setVisible( true )
    gameMenu\show!

close = ->
    gameMenu\hide!

return (screen) ->
    gameMenu = (require"client.gui.dialogs.game_menu")screen

    keypressed = (k) ->
        -- @todo
        -- if k == 'f5'
            -- love.event.quit('restart')
        if k == 'escape'
            screen"game"


    return {
        :update
        :draw

        :keypressed

        :open
        :close
    }
