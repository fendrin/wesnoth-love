----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love
import load_image from require'binary'


draw_unit = (unit, at_x, at_y, selected = false, draw_bars = true) ->

    r, g, b, a = love.graphics.getColor!

    assert(unit.side)
    ext = "~TC(#{unit.side},ellipse_red)"
    -- ext = "~TC(3,ellipse_red)"
    -- ext = "~TC(1,magenta)"

    local ellipse_top, ellipse_bottom
    if selected
        ellipse_top    = load_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}selected-top.png#{ext}"
        ellipse_bottom = load_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}selected-bottom.png#{ext}"
    else
        ellipse_top    = load_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}top.png#{ext}"
        ellipse_bottom = load_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}bottom.png#{ext}"

    love.graphics.draw(ellipse_top, at_x, at_y)

    love.graphics.draw(load_image(unit.image .. "~TC(#{unit.side},magenta)"), at_x, at_y)

    love.graphics.draw(load_image("misc/orb.png" .. '~RC(magenta>green)'), at_x, at_y)

    if unit.can_recruit
        love.graphics.draw(load_image("misc/leader-crown.png"),
            at_x, at_y)

    love.graphics.draw(ellipse_bottom, at_x, at_y)

    if draw_bars
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

    love.graphics.setColor(r,g,b,a)

return draw_unit
