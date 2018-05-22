love = love

get_image = require"client/image/image_path"

moan = require"client.lib.Moan.Moan"!


draw_background = (background) ->
    -- screen_height = love.graphics.getHeight!
    screen_width  = love.graphics.getWidth!
    -- height = background\getHeight!
    width  = background\getWidth!
    scale  = screen_width / width
    -- background_x = (screen_width  - background\getWidth! ) / 2
    -- background_y = (screen_height - background\getHeight!) / 2
    love.graphics.draw(background, 0,0, 0, scale, scale)
    -- love.graphics.draw(background, background_x, background_y)
    -- love.graphics.draw(background, background_x + background\getWidth!,
    --     background_y, 0, -1, 1, width, 0)
    -- love.graphics.draw(background, background_x - background\getWidth!,
    --     background_y, 0, -1, 1, width, 0)

local finished
local cfg
local partNumber
return (screen) ->
    return {
        open: (story) ->
            finished = false
            love.mouse.setVisible(false)
            cfg = story
            -- require'moon'.p cfg
            partNumber = 1
            for part in *story.part

                if part.background
                    part.background = get_image(part.background)

                if part.background_layer
                    for layer in *part.background_layer
                        layer.image = get_image(layer.image)
                -- portrait = love.graphics.newImage"assets/data/campaigns/An_Orcish_Incursion/images/portraits/lomarfel.png"
                title   = {"", {1,1,1}}
                message = {part.story}

                config  = {
                    image: nil -- portrait
                }
                moan.speak(title, message, config)
                -- moan.setSpeed(0)
            -- love.graphics.reset!
            -- if love.audio
                -- audio!
        close: ->
            -- love.graphics.reset!
            love.mouse.setVisible( true )
            -- love.audio.stop!
        update: (dt)->
            love.mouse.setVisible( false )
            unless moan.showingMessage
                unless finished
                    finished = true
                    screen"game"
            moan.update(dt)


        mousepressed: ->
            moan.advanceMsg!
            partNumber += 1

        draw: ->
            if part = cfg.part[partNumber]
                if part.background
                    draw_background(part.background)
                if part.background_layer
                    for layer in *part.background_layer
                        if layer.image
                            draw_background(layer.image)

            moan.draw!


        keypressed: (key)->
            if key == "escape"
                moan.clearMessages!
            moan.advanceMsg!
            partNumber += 1
    }
