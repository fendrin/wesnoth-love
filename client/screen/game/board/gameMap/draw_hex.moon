love = love
import get_unit    from require"wesnoth.api.units"
import get_terrain from require"wesnoth.api.map"

draw_terrain = require"client.screen.game.board.draw_terrain"
draw_unit    = require"client.screen.game.board.gameMap.draw_unit"

-- @todo avoid magic numbers
draw_coordinates = false
tile_h = 72
tile_w = 54
font_size = 12

-- images
darken = love.graphics.newImage"assets/data/core/images/terrain/darken.png"
hex_cursor = love.graphics.newImage"assets/images/misc/hover-hex.png"


draw_hex = (loc_x, loc_y, at_x, at_y, highlighted = true, hovered = false) ->
    -- gameState = gameState
    -- at_x = math.floor(at_x)
    -- at_y = math.floor(at_y)
    terrain = get_terrain(gameState, loc_x, loc_y)
    -- return unless terrain

    if draw_coordinates
        love.graphics.printf(
            "#{loc_x} / #{loc_y}",
            at_x + tile_w/4, at_y + (tile_h / 2) -
            font_size, tile_w, "center")

    draw_terrain(terrain, at_x, at_y)
    unless highlighted
        -- @todo
        love.graphics.draw(darken, at_x, at_y)
        -- love.graphics.setColor(0.5,0.5,0.5)
    -- else
        -- love.graphics.setColor(1,1,1)

    if unit = get_unit(gameState, loc_x, loc_y)
        draw_unit(unit, at_x, at_y)
    -- love.graphics.setColor(1,1,1)

    if hovered
        love.graphics.draw(hex_cursor, at_x, at_y)


return draw_hex
