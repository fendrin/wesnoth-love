----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


loging = loging
log    = loging"storyScreen"

Screen = require'screen.Screen'
engine = require'engine'


class Story extends Screen

    new: (director) =>
        @id = 'story'
        super(director)


    open: () =>
        engine.setCursorVisible(false)
        @finished = false
        super!


    showStory: (cfg) =>
        @story = cfg
        @partNumber = 1
        @seen = 1
        -- require'moon'.p cfg
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


    mousepressed: ( x, y, button, istouch, presses ) =>
        switch button
            when 1
                if @seen < #@story.part
                    @seen += 1
                    @partNumber = @seen
                    @moan\advanceMsg!
            when 2
                @moan\close!
                @director\activate'game'
            when 5
                if @partNumber < @seen
                    @moan\next!
                    @partNumber += 1
            when 4
                if @partNumber > 1
                    @partNumber -= 1
                    @moan\previous!


    draw: =>
        if part = @story.part[@partNumber]
            if part.background
                engine.drawBackground(part.background)
            if part.background_layer
                for layer in *part.background_layer
                    if layer.image
                        engine.drawBackground(layer.image)
        @moan\draw!
        -- super!


    keypressed: (key) =>
        if key == "escape"
            @moan\clearMessages!
        else
            @moan\advanceMsg!
        @partNumber += 1

