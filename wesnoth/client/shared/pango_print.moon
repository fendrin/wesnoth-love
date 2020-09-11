----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+



-- <b>: Bold
-- <big>: Makes font relatively larger, equivalent to <span size="larger">
-- <i>: Italic
-- <s>: Strikethrough
-- <sub>: Subscript
-- <sup>: Superscript
-- <small>: Makes font relatively smaller, equivalent to <span size="smaller">
-- <tt>: Monospace
-- <u>: Underline

loging = loging
log = loging"pango"

s="<span color='#BCB088' size='large' font-style='italic'>You are victorious!</span> Mylord,\nWhat schall we do know ? Schwenken!"

love = love

font_path = "assets/fonts/OldaniaADFStd-Regular.otf"

font = love.graphics.newFont( font_path, 16) -- , hinting, dpiscale )

import lines from require"pl.stringx"
import print from love.graphics

words  = (txt) -> txt\gmatch'([ ]*[^ ]*)'
twords = (txt) -> txt\gmatch'%S+'

fragment_tag_s  = (txt) -> txt\gmatch'([^<]*)<(.-)>'
fragment        = (txt) ->  txt\match'[^>]+$'

arg_value = (txt) -> txt\gmatch'([^ =]*)=([^ ]*)'

-- y = 0
first = true
print_items = (items) ->
    for item in *items
        with item
            if item.str
                print(.str, .x, .y)
            else
                switch item.name
                    when 'span'
                        if item.size
                            print(item.size, 0,0)
                        if first
                            first = false
                            for key, value in pairs item
                                log.warn"#{key}: #{value}"


print_line = (txt, y, width, item_list) ->

    x = 0
    -- line_width = 0
    line_height = 0
    for textfragment, foundtag in fragment_tag_s(txt)
        for word in words(textfragment)
            table.insert(item_list, { str: word, x: x, y: y })
            x += font\getWidth(word)
            line_height = math.max(line_height, font\getHeight!)
        tag = {}
        for tagArg in twords(foundtag)

            tag["#{tagArg}_da"] = true
            -- if tagArg == ""
                -- continue
            unless tag.name
                tag.name = tagArg
            arg, value = arg_value(tagArg)
            -- if first
                -- print(tagArg, 0,0)
                -- first = false
            tag[arg] = value
        table.insert(item_list, tag)

    for word in words(fragment(txt))
        table.insert(item_list, {
            str: word, x: x, y: y
        })
        -- print(word, x, y)
        x += font\getWidth(word)

    y += line_height
    return y


(txt, width = 800) ->
    -- x = 0
    y = 0
    item_list = {}
    for line in lines(s)
        y = print_line(line, y, width, item_list)

    return {
        -- @returns the height of the printing
        getHeight: -> return y

        print: (x_, y_) ->
            print_items(item_list, x_, y_)
    }

    -- limit = width + x
    -- print_line(s, x, y, width)


    -- love.graphics.setFont(font)

    -- for words in foundtag\gmatch'%S+'
        -- print(line, x, y)
    --     words = splitv(line)
    --     require"moon".p(words)
    --     for word in *words
    --         if word
    --             print(word, x, y)

    --     print(textfragment, x, y)
    --     print(foundtag, x, y)
    --     y += line_height
    -- print(s\match('[^>]+$'), x, y)
            -- parsefragment(self.parsedtext, textfragment)
            -- table.insert(self.parsedtext, self.resources[foundtag] or foundtag)

    -- for w in s\gmatch("%S+")
        -- print("'#{w}'", x, y)
        -- y += line_height

