
-- local parent
miniMap = require"client.miniMap"

open = (x, y) ->
    -- parent = par
    -- prefs\show!

close = ->
    -- prefs\hide!

return (screen) ->


    keypressed = (k) ->
    -- if k == 'f5'
        -- love.event.quit('restart')
        if k == 'escape'
            screen("game")


    -- exit = ->
        -- screen(parent)

    -- prefs = (require"client.gui.dialogs.preferences")(exit)

    return {
        update: miniMap.update
        draw: miniMap.draw

        :keypressed

        :open
        :close
    }
