----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- pango_printer = require"pango_printer"
-- import newFont from love.graphics

-- regular = "assets/fonts/OldaniaADFStd-Regular.otf"
-- italic  = "assets/fonts/OldaniaADFStd-Italic.otf"
-- bold    = "fonts/OldaniaADFStd-Bold.otf"
-- boldItalic = "fonts/OldaniaADFStd-BoldItalic.otf"
-- italic_font = newFont(italic)

love = love
import newImage, draw, setColor, rectangle, reset from love.graphics
import load_image from require'binary'


class Moan

    -- todo take from a config
    default_border_image = "assets/images/dialogs/thin_translucent-border-top.png"

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

        @boxY = 400
        @boxW = 400
        @boxX = 500
        @boxH = 100


    clear: () =>
        @chain = {}


    msg: (cfg) =>


    speak: (cfg) =>
        -- cfg.printer = printer_rich('\n<big>' .. cfg.title .. '\n\n<big>' .. cfg.text)
        assert(cfg.message)

        if image = cfg.image
            if type(image) == 'string'
                -- cfg.image = newImage(image)
                cfg.image = load_image(image)

        table.insert(@chain, cfg)
        if @active == 0
            @active = 1
            @seen = 1


    advanceMsg: () =>
        if @seen < #@chain
            @seen += 1
            @active = @seen


    next: () =>
        if @active < @seen
            @active += 1


    previous: () =>
        if @active > 1
            @active -= 1


    close: () =>
        @chain  = {}
        @active = 0


    show: () =>


    update: (dt) =>

        return if @active == 0
        active_msg = @chain[@active]
        return unless active_msg
        width  = love.graphics.getWidth!
        height = love.graphics.getHeight!
        content_height = @min_height
        -- if text_height = active_msg.printer.height
            -- content_height = math.max(text_height, content_height)

        @boxX = @left_offset
        @boxY = height - content_height

        @boxW = width - @right_offset
        @boxH = content_height

        if active_msg.image
            @image_y = height - active_msg.image\getHeight!


    showing: =>
        return @active != 0


    draw: () =>

        return if @active == 0

        active_msg = @chain[@active]
        border_x = 1
        boxColour = { 0, 0, 0, 0.6 }

        while border_x < @boxW
            draw(@border, border_x, @boxY - @border_height)
            border_x = border_x + @border_width

        setColor(boxColour)
        rectangle("fill", @boxX, @boxY, @boxW, @boxH)
        reset!

        image_width = 0
        if image = active_msg.image
            draw(image, 0, @image_y)
            image_width = image\getWidth!

        title_height = 0
        if title = active_msg.title or active_msg.speaker
            love.graphics.print(title, @boxX + image_width, @boxY)
            title_height = 20


        if text = active_msg.message
            love.graphics.print(text, @boxX + image_width, @boxY + title_height)
            -- pango_print(active_msg.text, @boxX + image_width, @boxY)

