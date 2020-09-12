----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- @todo
-- LOG_PREF = (require"shared.log")"preferences"

-- @todo
-- preferences_file = "preferences.moon"
-- if love.filesystem.getInfo(preferences_file)
--     LOG_PREF.info"Preferences file found"
-- else
--     LOG_PREF.info"Preferences file *not* found"

-- log = loging'preferences'

fs = require'client.shared.engine.filesystem'

-- default_file_name = 'client.default_preferences.moon'
save_file_name = 'preferences'

-- holds our current state
local setup
reload = () ->
    setup = fs.loadFile(save_file_name)

save = () ->
    success = fs.writeTable(setup, save_file_name)


unless love.filesystem.getInfo(save_file_name)
    -- log.info'no preferences file found'
    default = require"client.default_preferences"
    fs.writeTable(default, save_file_name)


reload!

-- love config values, same structure



getFullscreen = () ->
    return setup.window.fullscreen


setFullscreen = (is_enabled) ->
    setup.window.fullscreen = is_enabled


getFullscreenType = () ->
    return setup.window.fullscreentype

getAudio = () ->
    return setup.modules.audio


getWidth = () ->
    return setup.window.width

getHeight = () ->
    return setup.window.height

getTheme = () ->
    return setup.display.gui.theme

getStyle = () ->
    return setup.display.gui.style


getMasterVolume = () ->
    return setup.audio.volume.master

getMusicVolume = () ->
    return setup.audio.volume.music

getEffectsVolume = () ->
    return setup.audio.volume.effects

getInterfaceVolume = () ->
    return setup.audio.volume.interface

getTurnBellVolume = () ->
    return setup.audio.volume.music

-- todo move to engine
setVideoMode = () ->

    flags = {
        fullscreen: getFullscreen!
        fullscreentype: getFullscreenType!
        resizable: true
    }

    success = love.window.setMode( getWidth!, getHeight!, flags )
    return success

apply = () ->
    setVideoMode!




{
    :apply
    :save
    :reload

    :getFullscreen
    :setFullscreen

    :getFullscreenType
    :getWidth
    :getHeight

    :getAudio
    :getMasterVolume
    :getMusicVolume
    :getEffectsVolume
    :getInterfaceVolume
    :getTurnBellVolume

    :getTheme
    :getStyle
}
