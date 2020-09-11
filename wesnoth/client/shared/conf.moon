----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


preferences = require'client.shared.preferences'


(cfg) ->

    with cfg
        .identity = 'wesnoth'              -- The name of the save directory (string)
        .appendidentity = false            -- Search files in source directory before save directory (boolean)
        .version = "11.3"                  -- The LÖVE version this game was made for (string)
        .console = false                   -- Attach a console (boolean, Windows only)
        .accelerometerjoystick = true      -- Enable the accelerometer on iOS and Android by exposing it as a Joystick (boolean)
        .externalstorage = false           -- True to save files (and read from the save directory) in external storage on Android (boolean)
        .gammacorrect = false              -- Enable gamma-correct rendering, when supported by the system (boolean)

        with .audio
            .mic = false                 -- Request and use microphone capabilities in Android (boolean)
            .mixwithsystem = true        -- Keep background music playing when opening LOVE (boolean, iOS and Android only)

        with .window
            .title = "Wesnoth for Löve" -- The window title (string)
            .icon  = "assets/images/icons/icon-game.png" -- Filepath to an image to use as the window's icon (string)
            .width  = preferences.getWidth!  -- The window width (number)
            .height = preferences.getHeight! -- The window height (number)
            .borderless = false         -- Remove all border visuals from the window (boolean)
            .resizable  = true          -- Let the window be user-resizable (boolean)
            .minwidth   = 1280          -- Minimum window width if the window is resizable (number)
            .minheight  =  720          -- Minimum window height if the window is resizable (number)
            .fullscreen     = preferences.getFullscreen!     -- Enable fullscreen (boolean)
            .fullscreentype = preferences.getFullscreenType! -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
            .vsync = 1                  -- Vertical sync mode (number)
            -- todo iirc this was removed in latest love version
            .msaa  = 0                  -- The number of samples to use with multi-sampled antialiasing (number)
            .depth   = nil              -- The number of bits per sample in the depth buffer
            .stencil = nil              -- The number of bits per sample in the stencil buffer
            .display = 1                -- Index of the monitor to show the window in (number)
            .highdpi = false            -- Enable high-dpi mode for the window on a Retina display (boolean)
            .usedpiscale = true         -- Enable automatic DPI scaling when highdpi is set to true as well (boolean)
            .x = nil                    -- The x-coordinate of the window's position in the specified display (number)
            .y = nil                    -- The y-coordinate of the window's position in the specified display (number)

        with .modules
            .audio    = preferences.getAudio! -- Enable the audio module (boolean)
            .data     = true                  -- Enable the data module (boolean)
            .event    = true                  -- Enable the event module (boolean)
            .font     = true                  -- Enable the font module (boolean)
            .graphics = true                  -- Enable the graphics module (boolean)
            .image    = true                  -- Enable the image module (boolean)
            .joystick = true                  -- Enable the joystick module (boolean)
            .keyboard = true                  -- Enable the keyboard module (boolean)
            .math     = true                  -- Enable the math module (boolean)
            .mouse    = true                  -- Enable the mouse module (boolean)
            .physics  = true                  -- Enable the physics module (boolean)
            .sound    = preferences.getAudio! -- Enable the sound module (boolean)
            .system   = true                  -- Enable the system module (boolean)
            .thread   = true                  -- Enable the thread module (boolean)
            .timer    = true                  -- Enable the timer module (boolean), Disabling it will result 0 delta time in love.update
            .touch    = true                  -- Enable the touch module (boolean)
            .video    = true                  -- Enable the video module (boolean)
            .window   = true                  -- Enable the window module (boolean)

