love = love
local gameMenu

update = (dt) ->
    -- error"update in game_menu"

draw = ->

open = ->
    print"geme menu opened"
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
