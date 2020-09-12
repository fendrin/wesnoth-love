----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- @todo avoid magic numbers
draw_coordinates = false
tile_h = 72
tile_w = 54
font_size = 12


-- todo get rid of love
love = love

import load_image from require'binary'
draw_terrain = require"screens.game.board.draw_terrain"
draw_unit    = require"screens.game.board.gameMap.draw_unit"


get_unit = (state, x, y) ->
    board = state.board

    return board.units\get_unit_at(x, y)


get_terrain = (state, x, y) ->

    map = state.board.map

    if row = map[x]
        return row[y]
    else
        return nil


local hexcursors, darken
setup = () ->

    darken = load_image"terrain/darken.png"
    hexcursors = {}

    image_path   = 'misc/'
    top    = image_path .. 'hover-hex-top.png'
    bottom = image_path .. 'hover-hex-bottom.png'

    selected_top    = image_path .. 'hover-hex-enemy-top.png'
    selected_bottom = image_path .. 'hover-hex-enemy-bottom.png'

    with hexcursors
        .own = {}
        with .own
            .top    = load_image(top    .. '~RC(magenta>green)')
            .bottom = load_image(bottom .. '~RC(magenta>green)')
        .ally = {}
        with .ally
            .top    = load_image(top    .. '~RC(magenta>blue)')
            .bottom = load_image(bottom .. '~RC(magenta>blue)')
        .empty = {}
        with .empty
            .top    = load_image(top    .. '~RC(magenta>gold)')
            .bottom = load_image(bottom .. '~RC(magenta>gold)')
        .enemy = {}
        with .enemy
            .top    = load_image(top    .. '~RC(magenta>red)')
            .bottom = load_image(bottom .. '~RC(magenta>red)')

        .selected = {}
        with .selected
            .own = {}
            with .own
                .top    = load_image(selected_top    .. '~RC(magenta>green)')
                .bottom = load_image(selected_bottom .. '~RC(magenta>green)')
            .ally = {}
            with .ally
                .top    = load_image(selected_top    .. '~RC(magenta>blue)')
                .bottom = load_image(selected_bottom .. '~RC(magenta>blue)')
            .empty = {}
            with .empty
                .top    = load_image(selected_top    .. '~RC(magenta>gold)')
                .bottom = load_image(selected_bottom .. '~RC(magenta>gold)')
            .enemy = {}
            with .enemy
                .top    = load_image(selected_top    .. '~RC(magenta>red)')
                .bottom = load_image(selected_bottom .. '~RC(magenta>red)')


draw_hex = (loc_x, loc_y, at_x, at_y, highlighted = true, hovered = false, occupant = 'none', selected) ->

    --todo don't check that every time
    unless hexcursors
        setup!

    gameState = gameState
    at_x = math.floor(at_x)
    at_y = math.floor(at_y)
    terrain = get_terrain(gameState, loc_x, loc_y)

    if draw_coordinates
        love.graphics.printf(
            "#{loc_x} / #{loc_y}",
            at_x + tile_w/4, at_y + (tile_h / 2) -
            font_size, tile_w, "center")

    draw_terrain(terrain, at_x, at_y)

    unless highlighted
        love.graphics.draw(darken, at_x, at_y)

    if selected
        switch occupant
            when 'empty'
                love.graphics.draw(hexcursors.selected.empty.top, at_x, at_y)
            when 'ally'
                love.graphics.draw(hexcursors.selected.ally.top,  at_x, at_y)
            when 'own'
                love.graphics.draw(hexcursors.selected.own.top,   at_x, at_y)
            when 'enemy'
                love.graphics.draw(hexcursors.selected.enemy.top, at_x, at_y)
    elseif hovered
        switch occupant
            when 'empty'
                love.graphics.draw(hexcursors.empty.top, at_x, at_y)
            when 'ally'
                love.graphics.draw(hexcursors.ally.top,  at_x, at_y)
            when 'own'
                love.graphics.draw(hexcursors.own.top,   at_x, at_y)
            when 'enemy'
                love.graphics.draw(hexcursors.enemy.top, at_x, at_y)

    if unit = get_unit(gameState, loc_x, loc_y)
        draw_unit(unit, at_x, at_y)

    if selected
        switch occupant
            when 'empty'
                love.graphics.draw(hexcursors.selected.empty.bottom, at_x, at_y)
            when 'ally'
                love.graphics.draw(hexcursors.selected.ally.bottom,  at_x, at_y)
            when 'own'
                love.graphics.draw(hexcursors.selected.own.bottom,   at_x, at_y)
            when 'enemy'
                love.graphics.draw(hexcursors.selected.enemy.bottom, at_x, at_y)
    elseif hovered
        switch occupant
            when 'empty'
                love.graphics.draw(hexcursors.empty.bottom, at_x, at_y)
            when 'ally'
                love.graphics.draw(hexcursors.ally.bottom,  at_x, at_y)
            when 'own'
                love.graphics.draw(hexcursors.own.bottom,   at_x, at_y)
            when 'enemy'
                love.graphics.draw(hexcursors.enemy.bottom, at_x, at_y)


return draw_hex

