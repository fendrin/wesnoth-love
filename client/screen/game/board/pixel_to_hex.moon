tile_h = 72
tile_w = 54

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

return pixel_position_to_hex
