love = love
import get_map_size, get_terrain from require"wesnoth.api.map"
tile_h = 72
tile_w = 54
draw_terrain = require"client.screen.screens.game.board.draw_terrain"
line_size = 2

pixel_to_hex = require"client.screen.screens.game.board.pixel_to_hex"

local miniMap, miniMapScaled


local minimap_surface_x, minimap_surface_y
local minimap_scale


minimap_pixel_to_hex = (x, y) ->
    x -= minimap_surface_x
    y -= minimap_surface_y
    return pixel_to_hex(x/minimap_scale, y/minimap_scale)


drawn = false
setup = (dlg) ->
    drawn = false
    gameState = gameState

    gameMap_hex_w, gameMap_hex_h, border_size = get_map_size(gameState)
    miniMap_w = (gameMap_hex_w + 2*border_size + 0.5) * tile_w
    miniMap_h = (gameMap_hex_h + 2*border_size + 0.5) * tile_h
    miniMap   = love.graphics.newCanvas(miniMap_w, miniMap_h)

    widget_h = dlg.miniMap\getHeight!
    widget_w = dlg.miniMap\getWidth!

    miniMapScaled = love.graphics.newCanvas(widget_w, widget_h)


draw_ = (dlg) ->
    gameState = gameState
    gameMap_hex_w, gameMap_hex_h, border_size = get_map_size(gameState)

    love.graphics.setCanvas( miniMap )
    canvas_height = miniMap\getHeight!
    canvas_width  = miniMap\getWidth!

    for y=1-border_size, gameMap_hex_h+border_size
        for x=1-border_size, gameMap_hex_w+border_size
            x_pos = x * tile_w
            y_pos = y * tile_h
            y_pos += tile_h/2 if x % 2 == 0

            if terrain = get_terrain(gameState, x, y)
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

    love.graphics.setCanvas(miniMapScaled)
    -- borderCut = love.graphics.newQuad(tile_w/3, tile_h/2,
        -- canvas_width - tile_w/1.4,
        -- canvas_height - tile_h, miniMap\getDimensions!)
    -- love.graphics.draw(miniMap, borderCut,
        -- minimap_surface_x, minimap_surface_y,
        -- 0, minimap_scale, minimap_scale)
    love.graphics.draw(miniMap, 1, 1, 0, minimap_scale, minimap_scale)

    love.graphics.setCanvas!



draw = (dlg, gameMap_offset_x, gameMap_offset_y) ->
    unless drawn
        draw_(dlg)
        drawn = true

    -- canvas_height = miniMap\getHeight!
    -- canvas_width  = miniMap\getWidth!


    -- love.graphics.draw(miniMapScaled, borderCut,
    --     minimap_surface_x, minimap_surface_y,
    --     0, minimap_scale, minimap_scale)
    love.graphics.draw(miniMapScaled,
        minimap_surface_x, minimap_surface_y)

    -- draw the white coverage rectangle (which marks the visible map)
    love.graphics.setLineWidth( line_size )
    love.graphics.setLineStyle("smooth") -- alternative: "rough"
    gameMap_w = dlg.gameMap\getWidth!
    gameMap_h = dlg.gameMap\getHeight!
    love.graphics.rectangle("line",
        minimap_surface_x+(gameMap_offset_x-tile_w/3)*minimap_scale,
        minimap_surface_y+(gameMap_offset_y-tile_h/2)*minimap_scale,
        gameMap_w*minimap_scale, gameMap_h*minimap_scale)


mousepressed = (...) ->
    return false

update = (dlg, scroll_to_hex, dt) ->
    x, y = love.mouse.getPosition!
    if love.mouse.isDown( 1 )
        if dlg.miniMap\isAt(x,y)
            loc_x, loc_y = minimap_pixel_to_hex(x,y)
            -- log.debug"minimap click at #{loc_x}/#{loc_y}"
            scroll_to_hex(dlg, loc_x, loc_y)



{
    :setup

    :mousepressed

    :update, :draw
}

