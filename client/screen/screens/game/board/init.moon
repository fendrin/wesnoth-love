love = love
miniMap = require"client.screen.screens.game.board.miniMap"
gameMap = require"client.screen.screens.game.board.gameMap"
import get_map_size from require"wesnoth.api.map"


-- @todo
tile_w = 54
tile_h = 72


max_x_ = (dlg, gameMap_hex_w, border_size) ->
    widget_w = dlg.gameMap\getWidth!
    display_hex_w = math.floor(widget_w / tile_w)
    return (gameMap_hex_w + 2*border_size - display_hex_w - 0.75) * tile_w

max_y_ = (dlg, gameMap_hex_h, border_size) ->
    widget_h = dlg.gameMap\getHeight!
    display_hex_h = math.floor(widget_h / tile_h)
    return (gameMap_hex_h + 2*border_size - display_hex_h - 0.75) * tile_h

min_x = tile_h / 4
min_y = tile_h / 2
gameMap_offset_x = min_x
gameMap_offset_y = min_y

checkBoundaries = (dlg) ->

    gameState = gameState
    gameMap_hex_w, gameMap_hex_h, border_size = get_map_size(gameState)

    -- Check boundaries.
    -- Remove this section if you don't wish to be constrained to the map.
    max_x = max_x_(dlg, gameMap_hex_w, border_size)
    gameMap_offset_x = max_x if gameMap_offset_x > max_x
    gameMap_offset_x = min_x if gameMap_offset_x < min_x

    max_y = max_y_(dlg, gameMap_hex_h, border_size)
    gameMap_offset_y = max_y if gameMap_offset_y > max_y
    gameMap_offset_y = min_y if gameMap_offset_y < min_y


scroll_to_hex = (dlg, x, y) ->
    gameMap_offset_x = x * tile_w - dlg.gameMap\getWidth!/2
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

    gameMap.mousemoved(dlg, gameMap_offset_x, gameMap_offset_y,
        x, y, dx, dy, istouch )

    if love.mouse.getRelativeMode!
        gameMap_offset_x += dx
        gameMap_offset_y += dy


update = (dlg, dt) ->
    x, y = gameMap.update(dlg, dt)
    gameMap_offset_x += x
    gameMap_offset_y += y
    -- miniMap.update(dlg, scroll_to_hex, dt)
    checkBoundaries(dlg)


draw = (dlg) ->

    gameMap.draw(dlg, gameMap_offset_x, gameMap_offset_y)
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




