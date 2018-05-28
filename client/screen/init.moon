run_moon = require"run_moon"
love = love
log  = (require"log")"Screen"


export gameState = {
    board: {
        units: (require"wesnoth.unit_map")(30,30)
        sides: {}
    }
}


local active_screen
local next_screen
local screens
open_screen = (parent) ->
    active_screen = next_screen
    if newScreen = screens[active_screen]
        newScreen.open(parent)

local alpha
local blend_speed
local parent
screen = (id, parent_id) ->
    next_screen = id
    parent = parent_id
    unless active_screen
        alpha = -1
        open_screen(parent)
    else
        screens[active_screen].close!
        alpha = 0
        blend_speed = 4

screens = {
    game:    (require"client.screen.game")screen
    title:   (require"client.screen.title")screen
    menu:    (require"client.screen.game_menu")screen
    prefs:   (require"client.screen.preferences")screen
    map:     (require"client.screen.map")screen
    splash:  (require"client.screen.splash")screen
    story:   (require"client.screen.story")screen
    load:    (require"client.screen.load")screen
}


handle_command = (command) ->
    gameState = gameState
    switch command.command_name
        when "story"
            screen("story", command)
            return true

    return false


handle_server = ->
    client = love.thread.getChannel( 'client' )
    if command = client\pop!
        log.info"Handle Command: #{command.command_name}"
        return true if handle_command(command)
        if handler = screens[active_screen].handle_command
            return true if handler(command)
        assert(false,
            "unhandled command #{command.command_name} by #{active_screen}")
    return true


print_info = true
with love
    .update = (dt) ->

        if alpha >= 0
            alpha += dt*blend_speed
            if alpha > 1
                alpha = 1
                open_screen(parent)
                blend_speed = 0 - blend_speed

        run_moon(handle_server)
        run_moon(screens[active_screen].update, dt)

    .draw = ->
        run_moon(screens[active_screen].draw)
        if alpha > 0
            screen_width, screen_height = love.graphics.getDimensions!
            love.graphics.setColor(0,0,0, alpha)
            love.graphics.rectangle("fill", 0,0, screen_width, screen_height)
            love.graphics.reset!
        if print_info
            mem_used = math.ceil(collectgarbage('count')/1024)
            x = love.graphics.getWidth! - 80
            love.graphics.print("FPS: #{love.timer.getFPS!} " .. '\n' ..
            "RAM: #{mem_used}MB", x, 4)


    .mousepressed = (...) ->
        if mousepressed = screens[active_screen].mousepressed
            run_moon(mousepressed, ...)

    .mousereleased = (...) ->
        if mousereleased = screens[active_screen].mousereleased
            run_moon(mousereleased, ...)

    .mousemoved = (...) ->
        if mousemoved = screens[active_screen].mousemoved
            run_moon(mousemoved, ...)

    .keypressed = (key) ->
        if key == 'f11'
            with love.window
                -- success = -- @todo check the result
                .setFullscreen(not .getFullscreen!)
        if keypressed = screens[active_screen].keypressed
            run_moon(keypressed, key)


return screen
