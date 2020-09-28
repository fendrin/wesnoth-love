----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- loging = loging
-- log    = loging"screen"

Screen = require'screen.Screen'
engine = require'engine'


class Story extends Screen

    new: (director) =>
        @id = 'story'
        super(director)


    open: () =>
        engine.setCursorVisible(false)
        @finished = false
        @resize(engine.getDimensions!)
        super!


    showStory: (cfg) =>
        @story = cfg
        @partNumber = 1
        @seen = 1
        for part in *cfg.part
            config  = {
                image: nil
                message: part.story
            }
            @moan\speak(config)


    close: =>
        @moan\clear!
        super!


    update: (dt) =>
        @moan\update(dt)
        -- super!


    wheelmoved: (x, y) =>
        if y > 0
            @moan\selectUp!
        if y < 0
            @moan\selectDown!


    advance = () =>
        if @seen < #@story.part
            @seen += 1
            @partNumber = @seen
            @moan\advanceMsg!


    skip = () =>
        @moan\hide!
        @director\activate'game'


    next = () =>
        if @partNumber < @seen
            @moan\next!
            @partNumber += 1


    previous = () =>
        if @partNumber > 1
            @partNumber -= 1
            @moan\previous!


    mousepressed: ( x, y, button, istouch, presses ) =>
        switch button
            when 1
                advance(@)
            when 2
                skip(@)
            when 5
                next(@)
            when 4
                previous(@)


    resize: (w, h) =>
        @moan\resize(w, h)


    draw: =>
        if part = @story.part[@partNumber]
            if part.background
                part.background = engine.drawBackground(part.background)
            if part.background_layer
                for layer in *part.background_layer
                    if layer.image
                        layer.image = engine.drawBackground(layer.image)
        @moan\draw!
        -- super!


    keypressed: (key) =>
        switch key
            when 'left'
                previous(@)
            when 'right'
                next(@)
            when 'return'
                skip(@)
            when 'space'
                advance(@)

