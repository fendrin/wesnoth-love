----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- todo get rid of love
love = love
import newImage, draw, setColor, rectangle, reset from love.graphics
import load_image from require'binary'
PangoPrinter = require"pango_print"


class Moan

    -- todo take from a config
    default_border_image = "assets/images/dialogs/thin_translucent-border-top.png"
    text_offset = 20


    new: (cfg) =>
        @cfg = cfg
        @border = newImage(default_border_image)
        @border_height = @border\getHeight!
        @border_width  = @border\getWidth!
        @chain         = {}

        @active = 0

        @min_height = 200

        @right_offset = 0
        @left_offset  = 0

        @alpha = 1
        @mode  = 'fade_in'

        @boxY = 400
        @boxW = 400
        @boxX = 500
        @boxH = 100
        @width = 600


    clear: () =>
        @chain = {}
        @active = 0


    speak: (cfg) =>

        table.insert(@chain, cfg)
        if @active == 0
            @active = 1
            @seen = 1


    optionUp: () =>
        if @selectedOption > 1
            @selectedOption -= 1


    optionDown: () =>
        active_msg = @chain[@active]
        if #active_msg.option > @selectedOption
            @selectedOption += 1


    advanceMsg: () =>
        if @seen < #@chain
            @mode = 'fade_out'


    next: () =>
        if @active < @seen
            @active += 1


    previous: () =>
        if @active > 1
            @active -= 1


    show: () =>
        @hidden = false
        @resize(@width, @height)


    hide: () =>
        @hidden = true


    update_printer = () =>
        active_msg = @chain[@active]
        return unless active_msg

        if image = active_msg.image
            if type(image) == 'string'
                active_msg.image = load_image(image)

        image_width = 0
        if image = active_msg.image
            image_width = image\getWidth!

        width = @width - image_width - 2 * text_offset
        if printer = active_msg.printer
            return if printer.width == width

        if title = active_msg.title
            active_msg.printer = PangoPrinter("\n<span color='#BCB088' size='larger'>" .. title ..
                    '\n\n</span>' .. active_msg.message .. '\n\n', width)
        else
            active_msg.printer = PangoPrinter('\n' .. active_msg.message, width)

        if option = active_msg.option
            for item in *option
                if item.image
                    item.image = load_image(item.image)

                item.printer = PangoPrinter("<span size='larger'>" .. item.label .. '</span>' .. '\n' .. "<span color='#b2b2b2'>" .. item.description .. '</span>', width)


    speed = 3
    update: (dt) =>

        return if @hidden
        return if @active == 0

        switch @mode
            when 'fade_in'
                if @alpha < 1
                    @alpha += dt * speed

                if @alpha >= 1
                    @alpha = 1
                    @mode = 'full'

            when 'fade_out'
                if @alpha > 0
                    @alpha -= dt * speed

                if @alpha <= 0
                    @alpha = 0
                    @mode = 'fade_in'

                    @seen += 1
                    @active = @seen
                    @resize(@width, @height)

        active_msg = @chain[@active]
        return unless active_msg

        update_printer(@)


    isAt: (x, y) =>
        return true if y > @boxY


    showing: =>
        return @active != 0


    resize: (width, height) =>
        @width  = width
        @height = height
        update_printer(@)
        content_height = @min_height

        if active_msg = @chain[@active]
            if text_height = active_msg.printer\getHeight!
                content_height = math.max(text_height, content_height)
            if option = active_msg.option
                for i, item in ipairs(option)
                    content_height += math.max(item.printer\getHeight!, item.image\getHeight!)
                    if item.default and not @selectedOption
                        @selectedOption = i

        @boxX = @left_offset
        @boxY = height - content_height
        @boxW = width - @right_offset
        @boxH = content_height


    draw: () =>
        return if @hidden
        return if @active == 0

        active_msg = @chain[@active]
        border_x = 1
        -- todo avoid magic number
        boxColour = { 0, 0, 0, 0.6 }

        while border_x < @boxW
            draw(@border, border_x, @boxY - @border_height)
            border_x = border_x + @border_width

        setColor(boxColour)
        rectangle("fill", @boxX, @boxY, @boxW, @boxH)
        reset!

        -- todo avoid magic number
        image_width = 0
        if image = active_msg.image
            draw(image, 0, @height - image\getWidth!)
            image_width = image\getWidth!

        outline = true
        active_msg.printer\print(@boxX + image_width + text_offset, @boxY, @alpha, outline)

        text_y = active_msg.printer\getHeight! + @boxY

        if option = active_msg.option
            for i, item in ipairs(option)

                item_image_height = 0
                item_image_width  = 0
                if item_image = item.image
                    item_image_height = item_image\getHeight!
                    item_image_width  = item_image\getWidth!

                item_heigt = math.max(item.printer\getHeight!, item_image_height)

                if i == @selectedOption
                    rx = 2
                    mode = 'line'
                    style = 'rough'
                    love.graphics.setLineStyle( style )
                    love.graphics.setLineWidth( 1.5 )
                    red   = 72.5 / 255
                    green = 62.0 / 255
                    blue  = 29.4 / 255

                    love.graphics.setColor( red, green, blue, @alpha )
                    love.graphics.rectangle( mode, @boxX + image_width + text_offset , text_y, 250, item_heigt, rx) -- , ry, segments )

                    red   =  2.0 / 255
                    green = 12.5 / 255
                    blue  = 19.2 / 255
                    love.graphics.setColor( red, green, blue, @alpha - 0.2)

                    mode = 'fill'
                    love.graphics.rectangle( mode, @boxX + image_width + text_offset + 1, (text_y + 1), 250 - 2, item_heigt - 2, rx, ry, segments )
                    love.graphics.reset!

                if item_image = item.image
                    draw(item_image, image_width + text_offset, text_y)

                item_text_y_offset = 0
                if item.printer\getHeight! < item_image_height
                    item_text_y_offset =  (item_image_height - item.printer\getHeight!) / 2

                item.printer\print(@boxX + image_width + item_image_width + text_offset, text_y + item_text_y_offset, @alpha, outline)
                text_y += math.max(item.printer\getHeight!, item_image_height)

