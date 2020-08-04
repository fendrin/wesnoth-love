----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

love = love
local gameMenu


open = ->
    love.mouse.setVisible(true)
    gameMenu\show!

close = ->
    gameMenu\hide!

local next_action
handler = (action) ->
    next_action = action

return (screen) ->
    gameMenu = (require"client.gui.dialogs.game_menu")(handler)

    update = (dt) ->
        return unless next_action
        switch next_action
            when "exit"
                screen"title"
            when "quit"
                love.event.quit!
            when "preferences"
                screen("preferences", "game_menu")
            when "resume"
                screen"game"
        next_action = nil

    keypressed = (k) ->
        -- @todo
        -- if k == 'f5'
            -- love.event.quit('restart')
        if k == 'escape'
            screen"game"


    return {
        :update
        draw: ->

        :keypressed

        :open
        :close
    }
