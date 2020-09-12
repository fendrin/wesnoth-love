----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+



love = love
scroll_speed = 1500
mouse_scrolling = true

key_map  = require"hotkey"

treshhold = 50
get_speed = (border_distance, speed) ->
    speed * (1 - border_distance / treshhold)

-- scrolling = false
scroll = (dlg, dt) ->

    gameMap_offset_x = 0
    gameMap_offset_y = 0
    -- scrolling = false
    if love.mouse.getRelativeMode!
        -- scrolling = true
        return 0,0
    -- old_offset_x = gameMap_offset_x
    -- old_offset_y = gameMap_offset_y
    widget_w = dlg.gameMap\getWidth!
    widget_h = dlg.gameMap\getHeight!

    speed = scroll_speed * dt

	-- get keyboard input
    with love.keyboard
        gameMap_offset_y -= speed if .isDown(key_map.scroll_up)
        gameMap_offset_y += speed if .isDown(key_map.scroll_down)
        gameMap_offset_x -= speed if .isDown(key_map.scroll_east)
        gameMap_offset_x += speed if .isDown(key_map.scroll_west)

    -- get mouse input
    x, y = love.mouse.getPosition!
    if dlg.gameMap\isAt(x,y) and mouse_scrolling
        gameMap_offset_y -= get_speed(y, speed) if y < treshhold
        border_distance = widget_h - y
        if border_distance < treshhold
            gameMap_offset_y += get_speed(border_distance, speed)
        if x < treshhold
            gameMap_offset_x -= get_speed(x, speed)
        border_distance = widget_w - x
        if border_distance < treshhold
            gameMap_offset_x += get_speed(border_distance, speed)

    return gameMap_offset_x, gameMap_offset_y
    -- if old_offset_y != gameMap_offset_y or old_offset_x != gameMap_offset_x
        -- scrolling = true

return scroll
