
local prefs, parent


open = (par) ->
    parent = par
    prefs\show!

close = ->
    prefs\hide!

return (screen) ->


    keypressed = (k) ->
    -- if k == 'f5'
        -- love.event.quit('restart')
        if k == 'escape'
            screen(parent)



    exit = ->
        screen(parent)

    prefs = (require"shared.gui.dialogs.preferences")(exit)

    return {
        update: ->
        draw: ->

        :keypressed

        :open
        :close
    }
