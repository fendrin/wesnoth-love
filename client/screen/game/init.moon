log = (require"log")"gameScreen"
local screen
love = love

dlg = (require"client.gui.dialogs.game_screen")!

board = require"client.screen.game.board"
moan  = require"client.screen.game.moan"


open = ->
    board.setup(dlg)
    moan.setup!
    love.mouse.setVisible( true )
    board.resize(love.graphics.getDimensions!)
    dlg\show!


close = -> dlg\hide!


handle_command = (command) ->
    -- assert(false)
    return true if moan.handle_command(command)
    return false


update = (dt) ->
    moan.update(dt)
    board.update(dlg, dt)


draw = ->
    board.draw(dlg)
    moan.draw!


-- @todo
-- local mouse_restore_x, mouse_restore_y
mousepressed = (x, y, button, istouch) ->
    return true if moan.mousepressed(x, y, button, istouch)
    return true if board.mousepressed(dlg, x, y, button, istouch)
    return false


mousereleased = ( x, y, button, istouch ) ->
    if button == 3
        love.mouse.setRelativeMode(false)
        -- @todo
        -- love.mouse.setPosition(mouse_restore_x, mouse_restore_y)


keypressed = (key) ->
    if moan.keypressed(key)
        return

    switch key
        when 'f5'
            love.event.quit('restart')
        when 'escape'
            screen"menu"
        when 'm'
            screen'miniMap'


----
-- @return bool wheter or not the game is to be terminated.
quit = ->
    dlg = (require"client.gui.dialogs.yes_no")(
        "Do you want to quit the game?")
    ret = dlg.show!
    if ret
        log.info"Thanks for playing. Please play again soon!"
        return true
    else
        return false


resize = (w, h) ->
    moan.resize(w, h)
    board.resize(w, h)


mousemoved = (...) ->
    board.mousemoved(dlg, ...)


return (scr) ->
    screen = scr
    return {
        :open, :close
        :update, :draw
        :keypressed
        :handle_command
        :mousepressed, :mousereleased, :mousemoved
        :resize
        :quit
    }
