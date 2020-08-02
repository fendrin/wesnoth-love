love = love
import get_map_size from require"wesnoth.api.map"
import get_unit     from require"wesnoth.api.units"
pixel_to_hex = require"client.screens.game.board.pixel_to_hex"
draw_hex     = require"client.screens.game.board.gameMap.draw_hex"
scroll       = require"client.screens.game.board.gameMap.scroll"
update_unit  = require"client.screens.game.board.gameMap.update_unit"

-- local gameState
local border_size


local     gameMap_x
local     gameMap_y
local     gameMap_w
local     gameMap_h

local    display_hex_w
local     display_hex_h



tile_w = 54
tile_h = 72

local gameMap
local reach_map
-- locations
Location = require"Location"
hovered_hex  = Location!
selected_hex = Location!

viewing_side = 1


update_primary_unit = (dlg, unit) ->
    update_unit(dlg, "primary", unit)

update_secondary_unit = (dlg, unit) ->
    update_unit(dlg, "secondary", unit)


resize = ( w, h ) ->
    gameMap = love.graphics.newCanvas(w ,h)


left_mouse_press = (dlg, x, y) ->
    gameState = gameState

    if selected_hex.x == hovered_hex.x and
            selected_hex.y == hovered_hex.y
        selected_hex.x = nil
        selected_hex.y = nil
        reach_map = nil
    else
        selected_hex.x = hovered_hex.x
        selected_hex.y = hovered_hex.y
        if unit = get_unit(gameState, selected_hex.x, selected_hex.y)
            reach_map = unit.reach
            update_primary_unit(dlg, unit)
        else
            reach_map = nil


right_mouse_press = (x, y) ->
    return unless (selected_hex.x and selected_hex.y)
    if unit = get_unit(gameState, selected_hex.x, selected_hex.y)

        if unit.side == viewing_side

            if occupied = get_unit(gameState, hovered_hex.x, hovered_hex.y)
                print"attack if enemy, soon!"
            else
                move_request = {
                    request_name: "Move"
                    src_x: selected_hex.x
                    src_y: selected_hex.y
                    dst_x: hovered_hex.x
                    dst_y: hovered_hex.y
                }
                server = love.thread.getChannel( 'server' )
                server\push(move_request)

mousepressed = (dlg, x, y, button, istouch) ->
    return unless dlg.gameMap\isAt(x,y)
    switch button
        when 1
            left_mouse_press(dlg, x,y)
        when 2
            right_mouse_press(x,y)
        when 3
            -- @todo
            -- mouse_restore_x, mouse_restore_y = love.mouse.getPosition!
            love.mouse.setRelativeMode(true)
            print"mousewheel pressed"
            return true
        when 4
            print"button 4 pressed"
        when 5
            print"button 5 pressed"

    return false


draw_hex_ = (x, y, loc_x, loc_y, offset_x, offset_y) ->
    -- allows us to go beyond the edge of the map.
    x_pos = ((x-1) * tile_w) - offset_x
    y_pos = ((y-1) * tile_h) - offset_y
    y_pos += tile_h/2 if loc_x % 2 == 0

    selected = selected_hex.x == loc_x and
        selected_hex.y == loc_y

    in_reach = reach_map != nil and reach_map[loc_x] != nil and
        reach_map[loc_x][loc_y] != nil

    highlighted = selected_hex.x == nil or selected or in_reach
    draw_hex(loc_x, loc_y, x_pos, y_pos,
        highlighted,
        hovered_hex.x == loc_x and hovered_hex.y == loc_y)


buffer_size = 2
draw = (dlg, gameMap_offset_x, gameMap_offset_y) ->

    love.graphics.setCanvas(gameMap)
    love.graphics.clear!

    offset_x = gameMap_offset_x % tile_w
    offset_y = gameMap_offset_y % tile_h
    firstTile_x = math.floor(gameMap_offset_x / tile_w - border_size)
    firstTile_y = math.floor(gameMap_offset_y / tile_h - border_size)

    -- We have to buffer one tile before and behind our viewpoint.
    -- Otherwise, the tiles will just pop into view, and we don't want that.
    -- buffer_size = 2
    for y=0, display_hex_h + buffer_size
        for x=0, display_hex_w + buffer_size
            draw_hex_(x,y, x + firstTile_x, y + firstTile_y,
                offset_x, offset_y)

    -- draw the gameMap
    board = love.graphics.newQuad(0, 0, gameMap_w,
        gameMap_h, gameMap\getDimensions!)

    love.graphics.setCanvas!
    love.graphics.draw(gameMap, board, gameMap_x, gameMap_y)


-- update_terrain = (x, y) ->
--     dlg.secondaryUnitLocation.text = "#{x}/#{y}"
--     -- dlg.secondaryUnitImage.icon = "assets/data/core/images/terrain/hills/regular.png"


mousemoved = (dlg, gameMap_offset_x, gameMap_offset_y, x, y) ->

    gameState = gameState

    unless dlg.gameMap\isAt(x,y)
        hovered_hex.x = nil
        hovered_hex.y = nil
        return false

    hovered_x, hovered_y = pixel_to_hex(
        x + gameMap_offset_x, y + gameMap_offset_y)
    if hovered_x != hovered_hex.x or hovered_y != hovered_hex.y
        hovered_hex.x = hovered_x
        hovered_hex.y = hovered_y

        if unit = get_unit(gameState, hovered_x, hovered_y)
            if unit.side == viewing_side
                update_primary_unit(dlg, unit)
            else
                update_secondary_unit(dlg, unit)
        elseif selected_hex.x
            selected_unit = get_unit(gameState,
                selected_hex.x, selected_hex.y)
            update_primary_unit(dlg, selected_unit)
        else
            update_primary_unit(dlg)



    --     update_terrain(hovered_x,hovered_y)
    --     -- @todo
    --         -- if reach_map[hovered_x]
    --             -- step = reach_map[hovered_x][hovered_y]
    --                 -- unless step == true
    --                 -- require'moon'.p step
    --             -- while step
    --                 -- step = reach_map[step[1].x][step[1].y]
    --     if hovered_x > 0 and hovered_x <= gameMap_hex_w and
    --             hovered_y > 0 and hovered_y <= gameMap_hex_h
    --     else
    --         hovered_hex.x = nil
    --         hovered_hex.y = nil
    -- else
    return true

update = (dlg, dt) ->
    x,y = scroll(dlg, dt)
    return x, y


setup = (dlg) ->
    -- gS = gameState
    _, _, border_size = get_map_size(gameState)
    gameMap_x = dlg.gameMap\getX!
    gameMap_y = dlg.gameMap\getY!
    gameMap_w = dlg.gameMap\getWidth! + 3
    gameMap_h = dlg.gameMap\getHeight!
    display_hex_w = dlg.gameMap\getWidth!  / tile_w
    display_hex_h = dlg.gameMap\getHeight! / tile_h

{
    :mousepressed, :mousemoved
    :update, :draw
    :resize
    :setup
}
