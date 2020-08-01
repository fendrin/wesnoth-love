love = love

-- cursor_by_mouse = true
move_treshhold = 0.2
local adjacents
move_accu =
    NORTH: 0, SOUTH: 0, EAST: 0, WEST: 0
    NORTH_WEST: 0, NORTH_EAST: 0, SOUTH_WEST: 0, SOUTH_EAST: 0
move_direction = (direction, dt, hovered_hex) ->
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


move_cursor = (dt, hovered_hex) ->
    return unless hovered_hex.x
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


return move_cursor
