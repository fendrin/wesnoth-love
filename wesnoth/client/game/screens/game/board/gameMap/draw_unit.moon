----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- todo get rid of love
love = love
draw = love.graphics.draw
import load_image from require'binary'


icons = {}
get_icon = (path) ->
    if icon = icons[path]
        return icon
    else
        icons[path] = load_image(path)
        return icons[path]


get_ellipse = (side, selected, is_top, can_recruit, has_zoc) ->
    -- todo implement has_zoc
    base   = 'misc/ellipse-'
    leader = if can_recruit then 'leader-'   else ''
    status = if selected    then 'selected-' else ''
    top    = if is_top      then 'top.png'   else 'bottom.png'
    ext    = "~TC(#{side},ellipse_red)"
    return get_icon(base .. leader .. status .. top .. ext)


get_unit_image = (unit) ->
    return get_icon(unit.image .. "~TC(#{unit.side},magenta)")


draw_unit_bars = (unit, at_x, at_y) ->
    x_offset = 17
    y_offset = 13
    x = at_x + x_offset
    y = at_y + y_offset
    bar_h = unit.max_hitpoints * 0.7
    bar_w = 6
    line_w = 1
    radius = 3

    love.graphics.setColor(1,1,1, 0.65)
    love.graphics.setLineWidth(line_w)
    love.graphics.setLineStyle("smooth")
    love.graphics.rectangle("line", x, y, bar_w, bar_h, 1, radius)
    love.graphics.setLineStyle("rough")

    love.graphics.setColor(0,1,0, 0.5)
    love.graphics.rectangle("fill",
        x+math.ceil(line_w/2)-1, y+math.ceil(line_w/2),
        bar_w/2-line_w+1, bar_h-line_w-1)

    love.graphics.setColor(0,0,1, 0.5)
    love.graphics.rectangle("fill",
        x+bar_w/2, y+math.ceil(line_w/2),
        bar_w/2-line_w +1, bar_h-line_w-1)


draw_unit = (unit, at_x, at_y, selected = false, draw_bars = true) ->
    r, g, b, a = love.graphics.getColor!

    -- todo
    has_zoc = true
    ellipse_top    = get_ellipse(unit.side, selected, true,  unit.can_recruit, has_zoc)
    ellipse_bottom = get_ellipse(unit.side, selected, false, unit.can_recruit, has_zoc)

    draw(ellipse_top, at_x, at_y)
    draw(get_unit_image(unit), at_x, at_y)
    draw(get_icon('misc/orb.png~RC(magenta>green)'), at_x, at_y)
    draw(get_icon('misc/leader-crown.png'), at_x, at_y) if unit.can_recruit
    draw(ellipse_bottom, at_x, at_y)
    draw_unit_bars(unit, at_x, at_y) if draw_bars

    love.graphics.setColor(r,g,b,a)


return draw_unit

