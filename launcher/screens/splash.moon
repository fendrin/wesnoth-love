love = love
o_ten_one = require"launcher.lib.splashes.o-ten-one"
-- screen = require"shared.screen"

cfg = {
    -- fill: "rain"
    background: {0,0,0}
    delay_after: 1
    delay_before: 0.5
}

local splash_screen
return (screen) ->
    return {
        open: ->
            splash_screen = o_ten_one.new(cfg)
            splash_screen.onDone = ->
                screen"title"
            love.mouse.setVisible( false )
            love.graphics.reset!
        close: ->
            love.graphics.reset!
        update: (dt) ->
            splash_screen\update(dt)
        draw: ->
            splash_screen\draw!
        keypressed: (key) ->
            splash_screen\skip!
    }
