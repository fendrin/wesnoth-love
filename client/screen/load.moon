love = love



return (screen) ->

    handle_command = (command) ->
        switch command.command_name
            when "map"
                gameState.board.map = command
                return true
            when "Side"
                gameState.board.sides[command.side] = command
                return true
            when "Unit"
                gameState.board.units\place_unit(command,
                    command.x, command.y)
                return true
            -- when "Music"
            --     music.add_to_playlist(
            --         "assets/data/core/music/#{command.name}")
            --     return true
            when "gameConfig"
                gameState.gameConfig = command
                screen("title")
                return true
        return false


    return {
        open: (story) ->
            love.mouse.setVisible(false)
        close: ->
            love.mouse.setVisible( true )
        update: (dt)->
            love.mouse.setVisible( false )
        :handle_command
        draw: ->
            love.graphics.print("loading ...", 400,400)
        -- @todo implement 'cancel'?
        -- keypressed: (key)->
        --     if key == "escape"
    }
