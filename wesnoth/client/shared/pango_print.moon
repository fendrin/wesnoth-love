----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- todo
-- <b>: Bold
-- <s>: Strikethrough
-- <sub>: Subscript
-- <sup>: Superscript
-- <small>: Makes font relatively smaller, equivalent to <span size="smaller">
-- <tt>: Monospace
-- <u>: Underline

-- done
-- <i>: Italic
-- <big>: Makes font relatively larger, equivalent to <span size="larger">

-- todo add loging or remove
-- loging = loging
-- log    = loging"pango"
-- todo get rid of love
love = love
import print   from love.graphics
import lines   from require"pl.stringx"
import hex2rgb from require'image.utils'


-- todo take from config
font_size_tbl =
    smaller: 14
    normal:  16
    larger:  18


-- todo move to client/shared/binary
get_font_path = (font_name, font_type) ->
    return "assets/fonts/#{font_name}-#{font_type}.ttf"


-- todo move to client/shared/binary
font_cache = {}
get_font = (font_name, font_type, font_size) ->
    font_path = get_font_path(font_name, font_type)
    if type(font_size) == 'string'
        font_size = font_size_tbl[font_size]
    if path_cache = font_cache[font_path]
        if font = path_cache[font_size]
            return font
        else
            path_cache[font_size] = love.graphics.newFont(font_path, font_size)
            return path_cache[font_size]
    else
        font_cache[font_path] = {}
        return get_font(font_name, font_type, font_size)


class PangoPrinter

    trim            = (txt) ->  txt\match'^%s*(.*%S)'
    words           = (txt) -> txt\gmatch'([ ]*[^ ]*)'
    twords          = (txt) -> txt\gmatch'%S+'
    -- todo would be nice to combine the next two into one
    fragment_tag_s  = (txt) -> txt\gmatch'([^<]*)<(.-)>'
    fragment        = (txt) ->  txt\match'[^>]+$'
    arg_value       = (txt) ->  txt\match"([^ =]*)='([^ ]*)'"


    font_name  = 'Lato'
    font_type  = 'Regular'
    font_size  = 'normal'
    font_color = {0.7, 0.7, 0.7}
    parse_line = (txt, y, width, item_list) ->
        x = 0

        parse_testfragment = (textfragment, line_height) ->
            for word in words(textfragment)
                font = get_font(font_name, font_type, font_size)
                word_length = font\getWidth(word)
                line_height = math.max(line_height, font\getHeight!)
                if x + word_length > width
                    y += line_height
                    x = 0
                    word = trim(word)
                word = {{font_color[1], font_color[2], font_color[3], font_color[4] }, word}
                table.insert(item_list, { :word, :font, :x, :y })
                x += word_length
            return line_height

        line_height = 0
        for textfragment, foundtag in fragment_tag_s(txt)

            assert(textfragment)
            line_height = parse_testfragment(textfragment, line_height)

            tag_read = false
            for tagArg in twords(foundtag)
                unless tag_read
                    tag_read = true
                    switch tagArg
                        when 'span'
                            continue
                        when 'big'
                            font_size = 'larger'
                        when '/big'
                            font_size = 'normal'
                        when 'i'
                            font_type = 'Italic'
                        when '/i'
                            font_type = 'Regular'
                        when '/span'
                            font_size = 'normal'
                            font_type = 'Regular'
                            font_name = 'Lato'
                            font_color = {1, 1, 1, 1}
                else
                    arg, value = arg_value(tagArg)
                    switch arg
                        when 'size'
                            font_size = value
                        when 'color'
                            r, g, b = hex2rgb(string.sub(value, 2, 7))
                            font_color = {r / 256, g / 256, b / 256}

        if txt_fragment = fragment(txt)
            line_height = parse_testfragment(txt_fragment, line_height)
        else
            font = get_font(font_name, font_type, font_size)
            line_height = math.max(line_height, font\getHeight!)

        y += line_height
        return y


    new: (txt, width) =>
        @width = width
        assert(txt)
        assert(width)

        @alpha = 0

        @y = 0
        @items = {}
        for line in lines(txt)
            @y = parse_line(line, @y, width, @items)


    ----
    -- @returns the height of the printing
    getHeight: =>
        return @y


    ----
    -- @param x
    -- @param y
    print: (x, y, alpha = 1) =>
        for item in *@items
            item.word[1][4] = alpha
            print(item.word, item.font, x + item.x, y + item.y)


return PangoPrinter

