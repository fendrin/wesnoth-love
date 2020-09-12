----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love
miniMap = require"screens.game.board.miniMap"
gameMap = require"screens.game.board.gameMap"


-- @todo
tile_w = 54
tile_h = 72


-- calculate where in the map widget the map is located

-- first the x offset in pixels
map_x_ = (dlg) ->
    gameState = gameState
    panel_w = dlg.gameMap\getWidth!

    border_size = gameState.board.map.border_size
    map_hex_w   = gameState.board.map.width


    map_w   = (map_hex_w + 2*border_size  )  * tile_w

    if panel_w < map_w
        -- our map does not fit the screen horizontally
        return 0
    else
        -- we center the map in the middle of the window, not the widget
        window_w = love.graphics.getWidth!
        center_x = (window_w - map_w) / 2

        -- todo substract an amount if the map fits no longer (sidebar)
        return center_x



map_y_ = (dlg) ->
    gameState = gameState
    panel_h = dlg.gameMap\getHeight!
    map_h   = gameState.board.map.height * tile_h

    if panel_h < map_h
        -- our map does not fit the sceen vertically
        return 0
    else
        -- we center the map
        window_h = love.graphics.getHeight!
        center_y = (window_h - map_h) / 2

        return center_y



max_x_ = (dlg, gameMap_hex_w, border_size) ->
    widget_w = dlg.gameMap\getWidth!
    display_hex_w = math.floor(widget_w / tile_w)
    return (gameMap_hex_w + 2*border_size - display_hex_w - 0.75) * tile_w


max_y_ = (dlg, gameMap_hex_h, border_size) ->
    widget_h = dlg.gameMap\getHeight!
    display_hex_h = math.floor(widget_h / tile_h)
    -- return (gameMap_hex_h + 2*border_size - display_hex_h - 0.75) * tile_h
    return (gameMap_hex_h + 2*border_size - display_hex_h + 0.5) * tile_h



min_x = 0 -- tile_h / 4
min_y = 0 --tile_h / 2
gameMap_offset_x = min_x
gameMap_offset_y = min_y

checkBoundaries = (dlg) ->

    gameState = gameState
    gameMap_hex_w = gameState.board.map.width
    gameMap_hex_h = gameState.board.map.height
    border_size   = gameState.board.map.border_size


    -- Check boundaries.
    -- Remove this section if you don't wish to be constrained to the map.
    max_x = max_x_(dlg, gameMap_hex_w, border_size)
    gameMap_offset_x = max_x if gameMap_offset_x > max_x
    gameMap_offset_x = min_x if gameMap_offset_x < min_x

    max_y = max_y_(dlg, gameMap_hex_h, border_size)
    gameMap_offset_y = max_y if gameMap_offset_y > max_y
    gameMap_offset_y = min_y if gameMap_offset_y < min_y


scroll_to_hex = (dlg, x, y) ->
    gameMap_offset_x =     x * tile_w - dlg.gameMap\getWidth!/2
    gameMap_offset_y = (y+1) * tile_h - dlg.gameMap\getHeight!/2


-- local mouse_restore_x, mouse_restore_y
mousepressed = (...) -> -- (x, y, button, istouch) ->
    if loc = miniMap.mousepressed(...)
        scroll_to_hex(loc.x, loc.y)
        return true
    if loc = gameMap.mousepressed(...)
        return true

    return false


mousemoved = (dlg, x, y, dx, dy, istouch ) ->

    map_x = map_x_(dlg)
    map_y = map_y_(dlg)
    -- gameMap.mousemoved(dlg, gameMap_offset_x, gameMap_offset_y,
    --     x, y, dx, dy, istouch )
    gameMap.mousemoved(dlg, gameMap_offset_x, gameMap_offset_y,
        x - map_x, y - map_y, dx, dy, istouch )

    if love.mouse.getRelativeMode!
        gameMap_offset_x += dx
        gameMap_offset_y += dy


update = (dlg, dt) ->
    x, y = gameMap.update(dlg, dt)
    gameMap_offset_x += x
    gameMap_offset_y += y
    -- todo
    -- miniMap.update(dlg, scroll_to_hex, dt)
    checkBoundaries(dlg)


draw = (dlg) ->
    x = map_x_(dlg)
    y = map_y_(dlg)

    gameMap.draw(dlg, gameMap_offset_x, gameMap_offset_y, x, y)
    miniMap.draw(dlg, gameMap_offset_x, gameMap_offset_y)


resize = (w, h) ->
    gameMap.resize(w, h)


setup = (dlg) ->
    gameMap.setup(dlg)
    miniMap.setup(dlg)


{
    :setup

    :resize
    :mousepressed, :mousemoved

    :update, :draw
}

