moan = require"client.lib.Moan.Moan"!
get_image = require"client.image.image_path"
love = love

local moanCanvas

--- @todo get rid of magic number
magic_border_size = 3
setup = (dlg) ->
    width = dlg.gameMap\getWidth!
    height = dlg.gameMap\getHeight!
    if (not moanCanvas) or width != moanCanvas\getWidth! or
            height != moanCanvas\getHeight!
        moanCanvas = love.graphics.newCanvas(width + magic_border_size, height)


draw = ->
    love.graphics.setCanvas(moanCanvas)
    love.graphics.clear!
    moan.draw!

    love.graphics.setCanvas!
    love.graphics.draw(moanCanvas)


showingMessage = ->
    return moan.showingMessage

mousepressed = (x, y, button, istouch) ->
    if moan.showingMessage
        moan.advanceMsg!
        return true
    else
        false


keypressed = (key) ->
    if moan.showingMessage
        if key == 'escape'
            moan.clearMessages!
        else
            moan.keypressed(key)
        return true
    else
        return false


update = (dt) ->
    love.mouse.setVisible(moan.showingMessage == nil or
        not moan.showingMessage)
    moan.update(dt)
    return moan.showingMessage


handle_command = (command) ->
    if command.command_name == "message"
        local portrait
        if command.image
            portrait = get_image(command.image)
        title   = {command.speaker, {1,1,1}}
        message = {command.message}
        config  = {
            image: portrait
        }
        moan.speak(title, message, config)
        return true
    else
        return false


{
    :setup
    :showingMessage

    :mousepressed
    :keypressed

    :handle_command

    :update
    :draw
}
