love = love

handle_command = (command) ->
    gameState = gameState

    switch command
        when "float_label"
            texture = love.graphics.newCanvas(72, 72)

            love.graphics.setCanvas(texture)
            -- txt = command.label
            red = 1
            green = 0
            blue = 0
            alpha = 1

            love.graphics.setColor( red, green, blue, alpha )
            love.graphics.print("txt")
            love.graphics.setCanvas!
            buffer = 1
            system = love.graphics.newParticleSystem( texture, buffer )
            life = 5
            system\setParticleLifetime(life, life)
            system\setEmitterLifetime( life )
            system\setEmissionRate(1)
            system\setSizeVariation(1)
            system\setLinearAcceleration(0, -20, 0, -20)
            -- system\setColors(255, 255, 255, 255, 255, 255, 255, 0)

        if command.command_name == "Side"
            gameState.board.sides[command.side] = command
        if command.command_name == "Unit"
            gameState.board.units\place_unit(command, command.x, command.y)
        -- if command.command_name == "Music"
            -- music.add_to_playlist("assets/data/core/music/#{command.name}")

    return true

return handle_server
