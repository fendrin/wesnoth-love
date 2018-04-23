love = love
get  = require"filesystem"

key_map  = require"client.hotkey"
Location = require"Location"
run_nice = require"run_moon"
draw_terrain = require"client.draw_terrain"

get_image = require"client.image.image_path"

-- @todo enable moan again
-- moan = require"client.lib.Moan.Moan"
import wesnoth, helper from require"wesnoth"
log = (require"log")"gameScreen"

-- magic numbers
-- @todo fetch those values from preferences or config
line_size = 2
font_size = 12
scroll_speed = 700
tile_w = 54
tile_h = 72

local minimap_surface_x, minimap_surface_y
local minimap_scale

local display_hex_w, display_hex_h

local gameMap_hex_w, gameMap_hex_h
local gameMap_offset_x, gameMap_offset_y

-- locations
local hovered_hex, selected_hex

local border_size
-- dialogs
local dlg, gameMenu
-- images
local hex_cursor, darken

-- @todo read from config
draw_coordinates = false

-- canvas
local gameMap


----
--
-- @param x
-- @param y
-- @return the hex field coordinates of the pixel at x/y
pixel_position_to_hex = (x, y) ->

    -- adjust for the border cut
    y-= tile_h/2

    -- @todo some comments wouldn't hurt here.
    s = tile_h
    tesselation_x_size = tile_w * 2
	tesselation_y_size = s
	x_base = math.floor(x / tesselation_x_size) * 2
	x_mod  = math.fmod(x, tesselation_x_size)
	y_base = math.floor(y / tesselation_y_size)
	y_mod  = math.fmod(y, tesselation_y_size)

	x_modifier = 0
	y_modifier = 0

    if y_mod < tesselation_y_size / 2
        if x_mod * 2 + y_mod < s / 2
            x_modifier = -1
            y_modifier = -1
        elseif x_mod * 2 - y_mod < s * 3 / 2
            x_modifier = 0
            y_modifier = 0
        else
            x_modifier = 1
            y_modifier = -1
    else
        if x_mod * 2 - (y_mod - s / 2) < 0
            x_modifier = -1
            y_modifier = 0
        elseif x_mod * 2 + (y_mod - s / 2) < s * 2
            x_modifier = 0
            y_modifier = 0
        else
            x_modifier = 1
            y_modifier = 0

    x_tile = math.floor(x_base + x_modifier)
    y_tile = math.floor(y_base + y_modifier)

    -- @todo
    -- some hack which wasn't needed before the translation to moonscript
    if x_tile % 2 == 1
        y_tile += 1

	return x_tile, y_tile


----
--
--
--
minimap_pixel_to_hex = (x, y) ->

    x -= minimap_surface_x
    y -= minimap_surface_y

    return pixel_position_to_hex(x/minimap_scale, y/minimap_scale)


----
--
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


local minimap
local gameMap_w, gameMap_h
load = ->
    darken = love.graphics.newImage(
        get.assets("data/core/images/terrain/darken.png"))
    hex_cursor = love.graphics.newImage(
        get.assets("images/misc/hover-hex.png"))

    require"server.main"

    hovered_hex  = Location()
    selected_hex = Location()

    gameMap_hex_h, gameMap_hex_w, border_size = wesnoth.get_map_size!

    gameMap_offset_x = 0
    gameMap_offset_y = 0

    love.graphics.setFont(love.graphics.newFont(font_size))

    minigameMap_hex_w = (gameMap_hex_w + 2*border_size + 0.5) * tile_w
    minigameMap_hex_h = (gameMap_hex_h + 2*border_size + 0.5) * tile_h
    minimap   = love.graphics.newCanvas(minigameMap_hex_w, minigameMap_hex_h)

    width, height = love.graphics.getDimensions!
    gameMap = love.graphics.newCanvas(width, height)


scroll = (dt) ->
    widget_w = dlg.gameMap\getWidth!
    widget_h = dlg.gameMap\getHeight!
    display_hex_w = math.floor(widget_w / tile_w)
    display_hex_h = math.floor(widget_h / tile_h)

    speed = scroll_speed * dt

	-- get keyboard input
    with love.keyboard
        gameMap_offset_y -= speed if .isDown(key_map.scroll_up)
        gameMap_offset_y += speed if .isDown(key_map.scroll_down)
        gameMap_offset_x -= speed if .isDown(key_map.scroll_east)
        gameMap_offset_x += speed if .isDown(key_map.scroll_west)

    mouse_scrolling = true
    if mouse_scrolling
        treshhold = 50
        -- get mouse input
        x, y = love.mouse.getPosition!

        get_speed = (border_distance) ->
            speed * (1 - border_distance / treshhold)
        gameMap_offset_y -= get_speed(y) if y < treshhold
        border_distance = widget_h - y
        if border_distance < treshhold
            gameMap_offset_y += get_speed(border_distance)
        if x < treshhold
            gameMap_offset_x -= get_speed(x)
        border_distance = widget_w - x
        if border_distance < treshhold
            gameMap_offset_x += get_speed(border_distance)


-- cursor_by_mouse = true
move_treshhold = 0.2
local adjacents
move_accu =
    NORTH: 0, SOUTH: 0, EAST: 0, WEST: 0
    NORTH_WEST: 0, NORTH_EAST: 0, SOUTH_WEST: 0, SOUTH_EAST: 0
move_direction = (direction, dt) ->
    if love.keyboard.isDown(key_map.cursor[direction])
        if move_accu[direction] == 0
            hovered_hex = adjacents[direction]
            adjacents = nil
        move_accu[direction] += dt

        if move_accu[direction] > move_treshhold
            hovered_hex = adjacents[direction]
            adjacents = nil
            move_accu[direction] = 0
    elseif move_accu[direction] > 0
        move_accu[direction] = 0


move_cursor = (dt) ->
    unless adjacents
        adjacents = hovered_hex\adjacents!
    move_direction("NORTH", dt, adjacents)
    move_direction("EAST", dt, adjacents)
    move_direction("WEST", dt, adjacents)
    move_direction("NORTH_EAST", dt, adjacents)
    move_direction("NORTH_WEST", dt, adjacents)
    move_direction("SOUTH", dt, adjacents)
    move_direction("SOUTH_EAST", dt, adjacents)
    move_direction("SOUTH_WEST", dt, adjacents)


scroll_to_hex = (x, y) ->
    gameMap_offset_x = x * tile_w - dlg.gameMap\getWidth!/2
    gameMap_offset_y = (y+1) * tile_h - dlg.gameMap\getHeight!/2


update_ = (dt) ->

    x, y = love.mouse.getPosition!
    if love.mouse.isDown( 1 )
        if dlg.miniMap\isAt(x,y)
            loc_x, loc_y = minimap_pixel_to_hex(x,y)
            log.debug"minimap click at #{loc_x}/#{loc_y}"
            scroll_to_hex(loc_x, loc_y)

    if dlg.gameMap\isAt(x,y)
        dlg.location.text = "#{hovered_hex.x}/#{hovered_hex.y}"
        hovered_x, hovered_y = pixel_position_to_hex(
            x + gameMap_offset_x, y + gameMap_offset_y)
        if hovered_x > 0 and hovered_x < gameMap_hex_w and
                hovered_y > 0 and hovered_y < gameMap_hex_h
            hovered_hex.x = hovered_x
            hovered_hex.y = hovered_y
        else
            hovered_hex.x = nil
            hovered_hex.y = nil
        scroll(dt)
    else
        dlg.location.text = ""
        hovered_hex.x = nil
        hovered_hex.y = nil

    -- Check boundaries.
    -- Remove this section if you don't wish to be constrained to the map.
    max_x = ((gameMap_hex_w + 2*border_size) - display_hex_w) * tile_w
    min_x = tile_h / 4
    gameMap_offset_x = max_x if gameMap_offset_x > max_x
    gameMap_offset_x = min_x if gameMap_offset_x < min_x

    max_y = ((gameMap_hex_h + 2*border_size) - display_hex_h) * tile_h
    min_y = tile_h / 2
    gameMap_offset_y = max_y if gameMap_offset_y > max_y
    gameMap_offset_y = min_y if gameMap_offset_y < min_y

    -- @todo comment
    dlg\show! if (not dlg.isShown) and (not gameMenu.isShown)

    -- move_cursor(dt)
    -- moan.update(dt)


reach_map = {}

local terrain, display_hex_w, display_hex_h
local offset_x, offset_y, firstTile_x, firstTile_y


draw_miniMap = ->

    love.graphics.setCanvas( minimap )

    canvas_height = minimap\getHeight!
    canvas_width  = minimap\getWidth!

    for y=1-border_size, gameMap_hex_h+border_size
        for x=1-border_size, gameMap_hex_w+border_size
            x_pos = x * tile_w
            y_pos = y * tile_h
            y_pos += tile_h/2 if x % 2 == 0

            if terrain = wesnoth.get_terrain(x, y)
                draw_terrain(terrain, x_pos, y_pos)

    widget_x = dlg.miniMap\getX!
    widget_y = dlg.miniMap\getY!
    widget_h = dlg.miniMap\getHeight!
    widget_w = dlg.miniMap\getWidth!

    minimap_scale_h = widget_h / (canvas_height - tile_h)
    minimap_scale_w = widget_w / (canvas_width - tile_w/1.5)
    minimap_scale   = math.min(minimap_scale_w, minimap_scale_h)

    minimap_surface_x = widget_x +
        ((widget_w - ((canvas_width - tile_w/1.5) * minimap_scale)) / 2)
    minimap_surface_y = widget_y +
        ((widget_h - ((canvas_height - tile_h) * minimap_scale)) / 2)

    love.graphics.setCanvas!

    borderCut = love.graphics.newQuad(tile_w/3, tile_h/2,canvas_width - tile_w/1.4,
       canvas_height - tile_h, minimap\getDimensions!)
    love.graphics.draw(minimap, borderCut,
        minimap_surface_x, minimap_surface_y, 0, minimap_scale, minimap_scale)

    -- draw the white coverage rectangle (which marks the visible map)
    love.graphics.setLineWidth( line_size )
    love.graphics.setLineStyle("smooth") -- alternative: "rough"
    love.graphics.rectangle("line",
        minimap_surface_x+(gameMap_offset_x-tile_w/3)*minimap_scale,
        minimap_surface_y+(gameMap_offset_y-tile_h/2)*minimap_scale,
        gameMap_w*minimap_scale, gameMap_h*minimap_scale)


draw_hex = (loc_x, loc_y, at_x, at_y) ->
    terrain = wesnoth.get_terrain(loc_x, loc_y)
    return unless terrain

    draw_terrain(terrain, at_x, at_y)

    if draw_coordinates
        love.graphics.printf(
            "#{loc_x} / #{loc_y}",
            at_x + tile_w/4, at_y + (tile_h / 2) -
            font_size, tile_w, "center")

    if selected_hex.x
        highlighted = reach_map[loc_x] and
            reach_map[loc_x][loc_y]
        unless highlighted
            love.graphics.draw(darken, at_x, at_y)

    if hovered_hex.x == loc_x and
            hovered_hex.y == loc_y

        love.graphics.draw(hex_cursor, at_x, at_y)

    if unit = wesnoth.get_unit(loc_x, loc_y)
        love.graphics.draw(get_image(unit.image), at_x, at_y)


gameMap = love.graphics.newCanvas(gameMap_w, gameMap_h)
draw_gameMap = ->
    love.graphics.setCanvas(gameMap)

    display_hex_w = dlg.gameMap\getWidth!  / tile_w
    display_hex_h = dlg.gameMap\getHeight! / tile_h
    offset_x = gameMap_offset_x % tile_w
    offset_y = gameMap_offset_y % tile_h
    firstTile_x = math.floor(gameMap_offset_x / tile_w - border_size)
    firstTile_y = math.floor(gameMap_offset_y / tile_h - border_size)

    -- We have to buffer one tile before and behind our viewpoint.
    -- Otherwise, the tiles will just pop into view, and we don't want that.
    for y=0, display_hex_h + 2
        for x=0, display_hex_w + 1
            loc_y = y + firstTile_y
            loc_x = x + firstTile_x
            -- allows us to go beyond the edge of the map.
            continue unless loc_y >= 1 - border_size and
                loc_y <= gameMap_hex_h + border_size and
                loc_x >= 1 - border_size and
                loc_x <= gameMap_hex_w + border_size
            x_pos = ((x-1) * tile_w) - offset_x
            y_pos = ((y-1) * tile_h) - offset_y
            y_pos += tile_h/2 if loc_x % 2 == 0

            draw_hex(loc_x, loc_y, x_pos, y_pos)

    -- draw the gameMap
    gameMap_x = dlg.gameMap\getX!
    gameMap_y = dlg.gameMap\getY!
    gameMap_w = dlg.gameMap\getWidth!
    gameMap_h = dlg.gameMap\getHeight!

    top_left = love.graphics.newQuad(0, 0, gameMap_w,
        gameMap_h ,gameMap\getDimensions!)

    love.graphics.setCanvas!
    love.graphics.draw(gameMap, top_left, gameMap_x, gameMap_y)


draw = ->
    return if gameMenu and gameMenu.isShown

    draw_gameMap!
    draw_miniMap!

    print_info = true -- @todo
    if print_info
        mem_used = math.ceil(collectgarbage('count')/1024)
        love.graphics.print("FPS: #{love.timer.getFPS!} " ..
            "RAM: #{mem_used}MB", 10, 4)


select_hex = (x, y) ->
    selected_hex.x = x
    selected_hex.y = y
    path_turns_ = 0
    unless x
        return
    selected_unit = wesnoth.get_unit(selected_hex.x, selected_hex.y)
    if selected_unit
        reach = wesnoth.find_reach(selected_unit, {
            -- @todo translate the parameters
            -- pathfind.Paths(un, false, true, viewing_team(), path_turns_)
            additional_turns: path_turns_
        })
        reach_map = {}
        for step in *reach
            loc_x = step[1].x
            loc_y = step[1].y

            unless reach_map[loc_x]
                reach_map[loc_x] = {}
            reach_map[loc_x][loc_y] = true
    else
        new_x = selected_hex.x
        new_y = selected_hex.y
        reach_map = {
            [new_x]: {[new_y]: true}
        }
    log.debug"#{selected_hex} selected."


left_mouse_press = (x, y) ->
    if dlg.gameMap\isAt(x,y)
        if selected_hex == hovered_hex
            selected_hex.x = nil
        else
            select_hex(hovered_hex.x, hovered_hex.y)


mousepressed = (x, y, button, istouch) ->
    switch button
        when 1
            left_mouse_press(x,y)
        when 2
            if selected_hex
                helper.move_unit({selected_hex, hovered_hex})
                select_hex(hovered_hex)
        when 3
            print"mousewheel pressed"
        when 4
            print"button 4 pressed"
        when 5
            print"button 5 pressed"


keypressed = (k) ->
    if k == 'f5'
        love.event.quit('restart')
    if k == 'escape'
        if gameMenu.isShown
            gameMenu\hide!
            dlg\show!
        else
            dlg\hide!
            gameMenu\show!


game_screen = ->
    load!
    with love
        .draw       = draw
        .keypressed = keypressed
        .quit       = quit
        .update       = (dt) ->
            run_nice(()-> update_(dt))
        .mousepressed = (x, y, button, istouch) ->
            run_nice((-> mousepressed(x, y, button, istouch)))
    gameMenu = (require"client.gui.dialogs.game_menu")!
    dlg = (require"client.gui.dialogs.game_screen")!
    dlg\show!


return game_screen
