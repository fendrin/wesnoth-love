love = love
get_image = require"client/image/image_path"


draw_unit = (unit, at_x, at_y, selected = false) ->

    r, g, b, a = love.graphics.getColor!

    love.graphics.draw(get_image"misc/ellipse-top.png", at_x, at_y)

    -- local ellipse_top, ellipse_bottom
    ellipse_top = get_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}top.png"
    ellipse_bottom = get_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}bottom.png"


    -- if selected_hex.x and not (selected_hex.x == loc_x and
    --         selected_hex.y == loc_y)
    --     love.graphics.setColor(0.5,0.5,0.5)

        -- if selected_hex.x and (selected_hex.x == loc_x and
    --         selected_hex.y == loc_y)
    if selected
        ellipse_top = get_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}selected-top.png"
        ellipse_bottom = get_image"misc/ellipse-#{if unit.can_recruit then "leader-" else ""}selected-bottom.png"

    love.graphics.draw(ellipse_top, at_x, at_y)
    love.graphics.draw(get_image(unit.image .. "~RC"), at_x, at_y)
    love.graphics.draw(get_image("misc/orb.png~RC"), at_x, at_y)
    -- love.graphics.draw(get_image("misc/loyal-icon.png"), at_x, at_y)
    if unit.can_recruit
        love.graphics.draw(get_image("misc/leader-crown.png"),
            at_x, at_y)

    love.graphics.draw(ellipse_bottom, at_x, at_y)
    -- // We draw bars only if wanted, visible on the map view
    draw_bars = true --ac.draw_bars_ ;

    if draw_bars
        x_offset = 17
        y_offset = 13
        x = at_x + x_offset
        y = at_y + y_offset
        bar_h = unit.max_hitpoints * 0.7
        bar_w = 6
        line_w = 1
        radius = 3
        -- r, g, b, a = love.graphics.getColor!
        love.graphics.setColor(1,1,1, 0.65)
        love.graphics.setLineWidth(line_w)
        love.graphics.setLineStyle("smooth")
        love.graphics.rectangle("line", x, y, bar_w, bar_h, 1, radius)
        love.graphics.setLineStyle("rough")

        love.graphics.setColor(0,1,0, 0.5)
        love.graphics.rectangle("fill",
            x+math.ceil(line_w/2)-1, y+math.ceil(line_w/2),
            bar_w/2-line_w+1, bar_h-line_w-1)
            -- 1, radius)
        love.graphics.setColor(0,0,1, 0.5)
        love.graphics.rectangle("fill",
            x+bar_w/2, y+math.ceil(line_w/2),
            bar_w/2-line_w +1, bar_h-line_w-1)
            -- 1, radius)
    love.graphics.setColor(r,g,b,a)

return draw_unit
