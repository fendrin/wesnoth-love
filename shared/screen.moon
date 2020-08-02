run_moon = require"run_moon"
love = love
log  = (require"log")"Screen"


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
    error"unknown screen" unless screens[id]
    parent = parent_id
    unless active_screen
        alpha = -1
        open_screen(parent)
    else
        screens[active_screen].close!
        alpha = 0
        blend_speed = 4

client_screens_path    = "client.screens"
launcher_screens_path  = "launcher.screens"
-- shared_screens_path    = "shared.screens"

client_screen_list    = {"game", "game_menu", "story", "prestart"}
launcher_screen_list  = {"title", "splash", "load"}
-- shared_screen_list    = {"preferences"}

screens = {}
-- for screen_name in *shared_screen_list
    -- screens[screen_name] = (require"#{shared_screens_path}.#{screen_name}")screen
for screen_name in *launcher_screen_list
    screens[screen_name] = (require"#{launcher_screens_path}.#{screen_name}")screen
for screen_name in *client_screen_list
    screens[screen_name] = (require"#{client_screens_path}.#{screen_name}")screen

handle_command = (command) ->

handle_server = ->
    client = love.thread.getChannel( 'client' )
    if command = client\pop!
        log.debug"Handle Command: #{command.command_name}"
        if handle_command(command)
            log.debug"Command #{command.command_name} handled by screen itself."
            return true
        if handler = screens[active_screen].handle_command
            if handler(command)
                log.debug"Command #{command.command_name} handled by #{active_screen}."
                return true
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
