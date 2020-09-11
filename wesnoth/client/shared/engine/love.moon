----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love
import openURL                     from love.system
import newSource, play, setVolume  from love.audio
import quit                        from love.event
import setPosition, setVisible,
    newCursor, setCursor           from love.mouse
import newImageData from love.image
import newImage, getHeight, setColor, rectangle, reset,
    getDimensions, getWidth, draw, print  from love.graphics
import getFPS from love.timer
import getChannel from love.thread

preferences = require'client.shared.preferences'
loging = loging
log = loging"engine"


drawPerformance = () ->
    mem_used = math.ceil(collectgarbage('count')/1024)
    x, y = 4, 4
    print("FPS: #{getFPS!} " .. '\n' ..
            "RAM: #{mem_used}MB", x, y)


image_store = {}
drawBackground = (background) ->
    import get_image from require'binary'

    assert(background)
    if type(background) == 'string'
        fs_path = get_image(background)
        if stored = image_store[fs_path]
            background = stored
        else
            image_store[fs_path] = newImage(fs_path)
            background = image_store[fs_path]

    screen_height = getHeight!
    screen_width  = getWidth!
    image_height  = background\getHeight!
    image_width   = background\getWidth!

    scale = screen_height / image_height
    scaled_height = image_height * scale
    scaled_width  = image_width * scale

    x = (screen_width  - scaled_width ) / 2
    y = (screen_height - scaled_height) / 2
    love.graphics.draw(background, x, y, 0, scale, scale)
    love.graphics.reset!


bindHandler = (handler, role) ->
    love[role] = handler


blendScreen = (alpha) ->
    screen_width, screen_height = getDimensions!
    setColor(0,0,0, alpha)
    rectangle("fill", 0,0, screen_width, screen_height)
    reset!


loveOpenURL = (url) ->
    success = openURL( url )
    return success


sounds = {}
lovePlay = (path, volume = 1.0) ->

    unless sounds[path]
        sound = newSource(path, 'stream')
        sounds[path] = sound
        return lovePlay(path, volume)

    sounds[path]\setLooping(false)
    -- set volume for all instances
    sounds[path]\setVolume(volume)
    play(sounds[path])

    return true


playMusic = (path, volume) ->
    import get_music from require'binary'
    fs_path = get_music(path)

    lovePlay(fs_path, preferences\getMusicVolume!)


playSound = (path, volume) ->
    import get_sound from require'binary'
    fs_path = get_sound(path)

    lovePlay(fs_path, 1.0)


assets = require'client.shared.assets'
cursors = {}
for id, cursor_cfg in pairs(assets.cursors)
    with cursor_cfg
        cursors[id] = newCursor(newImageData(.image), .x, .y)

loveSetCursor = (id) ->
    assert(id)

    if cursor = cursors[id]
        setCursor(cursor)
    else
        log.warn"Unknown Mouse Cursor: #{id}"


-- todo enhance stub
unMute = ->
    setVolume(1)


pop = ->
    client = getChannel( 'client' )
    return client\pop!


setCursorVisible = (visible) ->
    setVisible(visible)


pointer2dialog = (dialog, widget_id) ->
    if widget = dialog[widget_id]
        setPosition(widget\getX!, widget\getY!)
    else
        log.warn"pointer2dialog: #{widget_id} widget not found"

    loveSetCursor"normal"
    dialog\show!
    setVisible(true)


drawTopCenter = (image, y = 0) ->
    screen_width = getWidth!
    -- todo
    scale = 1.0
    x = (screen_width  - image\getWidth! * scale ) / 2
    draw(image, x, y, 0, scale, scale)
    reset!


startServer = () ->
    -- todo handle more gracefully
    love.threaderror = (thread, errorstr) ->
        -- thread:getError() will return the same error string now.
        log.error("Thread error!\n"..errorstr)
        quit!

    export server = love.thread.newThread("wesnoth/server/main.lua")
    server\start!


sendRequest = (request) ->
    server = love.thread.getChannel( 'server' )
    server\push(request)


-- todo think about love.quit
loveQuit = (exitstatus) ->
    switch exitstatus
        when "restart"
            log.info"Restarting...\n"
        when 0
            log.info"Normal exit...\n"
        else
            log.error"quit with exit status: #{exitstatus}"

    sendRequest{ name: 'disconnect' }

    server = server
    running = false
    if server
        log.info"server object found"
        running = server\isRunning!
        log.info"servis is running: #{running}"
    else
        log.info'server object not found'
    while running
        running = server\isRunning!

    quit(exitstatus)


loveGetDimension = () ->
    return getDimensions!


restart = -> loveQuit'restart'


import loadConfig, deleteLogs, removeConfig, install, logPathes, writeConfig, getRequirePath from require'client.shared.engine.filesystem'

{
    getDimensions: loveGetDimension
    :setCursorVisible
    :loadConfig
    :sendRequest
    :startServer
    :playSound
    :playMusic
    :logPathes
    :writeConfig
    setRequirePath: require"wesnoth.shared.setRequirePath"
    :getRequirePath
    :restart
    :removeConfig
    :install
    :pop
    :drawPerformance
    :drawBackground
    :deleteLogs
    :drawTopCenter
    :unMute
    :bindHandler
    :blendScreen
    setCursor: loveSetCursor
    openURL: loveOpenURL
    :pointer2dialog
    quit: loveQuit
    play: lovePlay
}

