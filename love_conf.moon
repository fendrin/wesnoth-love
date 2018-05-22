version =
    major: 0
    minor: 0
    patch: 0

local irdya_version
with version
    irdya_version = "#{.major}.#{.minor}.#{.patch}"

game_title = "Wesnoth"
game_id    = "wesnoth"

love_version = "11.0" -- version of love2d engine

return ( config ) ->

    with config
        .identity = game_id
        .version  = love_version
        .console  = true
        with .window
            .title      = "#{game_title} | Irdya (v#{irdya_version})"
            -- .icon       = "assets/icons/#{game_id}-icon.png"
            -- .msaa       = 4
            -- .width      = 1920
            -- .minwidth   = 800
            -- .height     = 1080
            -- .minheight  = 480
            -- .borderless = false
            -- .resizable  = true
            .fullscreen = true
            .vsync      = false
        -- with .modules
            -- .physics = false
            -- .math    = false
            -- .thread  = false
            -- .audio   = false
            -- .sound   = false
            -- .video   = false
