----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- engine   = require'client.shared.engine'
run_moon = require"run_moon"

loging = loging
log    = loging'screen'


export love_hooks = {}
love.update = (dt) -> love_hooks.update(dt)
love.draw   =      -> love_hooks.draw!


class Director

    new: (screens) =>
        @screens = {}
        for id, screenClass in pairs screens
            log.debug"constructing the #{id} screen"
            @screens[id] = screenClass(@)
        -- @active_screen = nil
        -- @next_screen = nil
        -- @parent

        -- @alpha = 1
        -- @blend_speed


    -- open_screen = (parent) =>
    --     engine.unMute!
    --     @active_screen = @next_screen
    --     if newScreen = @active_screen
    --         newScreen\open(parent)


    ----
    -- activate the screen with the @id
    activate: (id, parent_id) =>
        log.debug"screen called, id is #{id}, parent is #{parent_id}"
        log.error"unknown screen: #{id}" unless @screens[id]

        -- @active_screen = @screens[id]
        -- open_screen(@active_screen)


        -- @next_screen = @screens[id]
        if @active_screen
            @active_screen\close!
        @active_screen = @screens[id]
        @active_screen\open!
        -- open_screen(@)

        -- @parent = parent_id
        -- unless @active_screen
        --     @alpha = -1
        --     open_screen(@parent)
        -- else
        --     @active_screen.close!
        --     @alpha = 0
        --     @blend_speed = 4


    update = (dt) =>
        -- return unless @active_screen
        -- if @alpha >= 0
        --     @alpha += dt * @blend_speed

        --     engine.decreaseVolume(dt) -- love.audio.setVolume(love.audio.getVolume! - dt)

        --     if @alpha > 1
        --         @alpha = 1
        --         run_moon(->open_screen(@parent))

        --         @blend_speed = 0 - @blend_speed

        @active_screen\update(dt)


    draw = () =>
        -- assert(false)
        -- return unless @active_screen
        -- assert(false)
        @active_screen\draw!
        -- if @alpha > 0
            -- engine.blendScreen(@alpha)


    ----
    -- hooks into the love engine
    -- by replacing its default handler functions
    hook: =>

            -- todo try other syntax
        -- engine.bindHandler('update', (dt) -> run_moon(->update(dt)) )
        love_hooks.update = (dt) -> run_moon(update, @, dt)
        -- engine.bindHandler('draw', -> run_moon(draw))
        love_hooks.draw = -> run_moon(draw, @)

        love.mousepressed = (x, y, button, istouch, presses) ->
            return unless @active_screen
            if mousepressed = @active_screen.mousepressed
                run_moon(mousepressed, @active_screen, x, y, button, istouch, presses)

            -- .mousereleased = (...) ->
            --     return unless @active_screen
            --     if mousereleased = @active_screen.mousereleased
            --         run_moon(mousereleased, ...)

        love.mousemoved = (...) ->
                return unless @active_screen
                if mousemoved = @active_screen.mousemoved
                    run_moon(mousemoved, @active_screen, ...)

        love.keypressed = (key) ->
            return unless @active_screen
            if key == 'f11'
                with love.window
                    -- success = -- @todo check the result
                    .setFullscreen(not .getFullscreen!)
            if keypressed = @active_screen.keypressed
                run_moon(keypressed, @active_screen, key)

        love.filedropped = (file) ->
            --     return unless @active_screen
            if filedropped = @active_screen.filedropped
                run_moon(filedropped, @active_screen, file)

        love.resize = (width, height) ->
            if resize = @active_screen.resize
                run_moon(resize, @active_screen, width, height)

