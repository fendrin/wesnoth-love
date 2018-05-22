moan = require"client.lib.Moan.Moan"!
get_image = require"client.image.image_path"
love = love

local moanCanvas

setup = ->
    -- if (not moanCanvas) or dlg.gameMap\getWidth! != moanCanvas\getWidth! or
    --         dlg.gameMap\getHeight! != moanCanvas\getHeight!
    width, height = love.graphics.getDimensions!
    moanCanvas = love.graphics.newCanvas(950, height)
    -- moanCanvas = love.graphics.newCanvas(
        -- dlg.gameMap\getWidth! + 3, dlg.gameMap\getHeight!)


draw = ->
    love.graphics.setCanvas(moanCanvas)
    moan.draw!
    love.graphics.setCanvas!

    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(moanCanvas)
    love.graphics.setBlendMode("alpha")


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
    assert(false)
    if command.command_name == "Message"
        require'moon'.p command
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

    :mousepressed
    :keypressed

    :handle_command

    :update
    :draw
}
