----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


engine    = require"engine"
import load_image from require'binary'

Screen    = require'screen.Screen'

menu      = require"gui.dialogs.local_menu"
campaign  = require"gui.dialogs.campaign"


loging = loging
log    = loging"screen"


class TitleLocal extends Screen

    handler = (action) =>
        -- print action
        @next_action = action


    campaign_handler = (id) =>
        if id
            @campaign = id
        else
            @localMenu\show!
            @moan\show!


    new: (director) =>
        @localMenu  = menu((action) -> handler(@, action))
        @id = 'titleLocal'
        super(director)


    tips_ready = false
    setup_tips = () =>
        return if tips_ready
        tips_ready = true
        DATA = DATA
        for tip in *DATA.Tip
            config  = {
                title:   tip.source
                message: tip.text
                image:   tip.portrait --and load_image(tip.portrait)
            }
            @moan\speak(config)


    mousepressed: ( x, y, button, istouch, presses ) =>
        switch button
            when 1
                if @moan\isAt(x, y)
                    @moan\advanceMsg!


    open: =>
        DATA = DATA

        @campaign_dlg = campaign( ((action) -> campaign_handler(@, action)), DATA.Campaign)
        @logo_bg    = load_image(DATA.Game_Config.images.game_logo_background)
        @logo_text  = load_image(DATA.Game_Config.images.game_logo)
        @background = load_image(DATA.Game_Config.images.game_title_background)
        @map        = load_image(DATA.Game_Config.images.game_title)

        engine.playMusic(DATA.Game_Config.title_music)

        setup_tips(@)

        engine.pointer2dialog(@localMenu, "localMenu")
        -- todo get rid of love
        love = love
        @resize(love.graphics.getWidth!, love.graphics.getHeight!)
        super!


    resize: (width, height) =>
        @moan\resize(width, height)


    close: =>
        @localMenu\hide!
        super!


    update: (dt) =>
        switch @next_action
            when 'campaign'
                @localMenu\hide!
                @campaign_dlg\show!
                @moan\hide!
            when "exit"
                engine.quit"restart"
            when "quit"
                engine.quit(0)
            when "preferences"
                @director\activate'preferences'

        @next_action = nil

        if @campaign
            log.info"Starting the campaign #{@campaign}"

            config = {
                mode: 'game'
                campaign: @campaign
            }
            engine.writeConfig(config)
            engine.restart!

            @campaign = nil

        @moan\update(dt)
        super(dt)


    draw: =>
        with engine
            .drawBackground(@background)
            .drawBackground(@map)
            .drawTopCenter(@logo_bg, 40)
            .drawTopCenter(@logo_text, 40)
        @moan\draw!
        super!


    keypressed: (key) =>
        if key == 'escape'
            engine.restart!
        if key == 'space'
            @moan\advanceMsg!

