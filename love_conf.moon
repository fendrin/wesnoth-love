----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


version =
    major: 0
    minor: 0
    patch: 0

local v4l_version
with version
    v4l_version = "#{.major}.#{.minor}.#{.patch}"

game_title = "Wesnoth for Löve"
game_id    = "wesnoth4love"

love_version =
    major: 11
    minor: 1
    -- patch:

love_version = "#{love_version.major}.#{love_version.minor}"

return ( config ) ->

    with config
        .identity = game_id
        .version  = love_version
        .console  = true
        with .window
            .title      = "#{game_title} (v#{v4l_version})"
            .icon       = "assets/images/icons/icon-game.png" -- todo take from a config file
            -- .msaa       = 4
            -- .width      = 1920
            -- .minwidth   = 800
            -- .height     = 1080
            -- .minheight  = 480
            -- .borderless = false
            -- .resizable  = true
            .fullscreen = true
            -- .vsync      = false
        -- with .modules
            -- .physics = false
            -- .math    = false
            -- .thread  = false
            -- .audio   = false
            -- .sound   = false
            -- .video   = false
