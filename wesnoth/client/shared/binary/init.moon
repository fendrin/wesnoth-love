----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


loging = loging
log    = loging'binary'


search = (bin_path, path) ->
    love = love

    search_path = "assets/" .. bin_path .. "/" .. path
    log.debug("searching at: " .. search_path)

    if love.filesystem.getInfo(search_path)
        return search_path
    return nil


get_binary = (path) ->
    DATA = DATA
    log.debug('searching for ' .. path)

    for bin_path in *DATA.Binary_Path
        if found = search(bin_path.path, path)
            return found

    log.warn"Image #{path} not found"
    return nil


get_image = (path) ->
    return nil unless path
    assert(type(path) == 'string')

    if found = search('', path)
        return found
    return get_binary('images/' .. path)


recolor = require'image.re_color'

image_path = (path) ->
    love = love
    path, ext = path\match'([^~]*)~?(.*)'

    local realpath
    if res = search('', path)
        realpath = res
    else
        realpath = get_image(path)

    if ext
        command, arg = ext\match'([^%(]*)%(([^%)]*)%)'

        switch command

            when 'RC'
                palette, range = arg\match'([^>]*)>(.*)'
                imgData = love.image.newImageData(realpath)

                return recolor(imgData, palette, range)

            when 'TC'
                range, palette = arg\match'([^,]*),(.*)'
                imgData = love.image.newImageData(realpath)

                return recolor(imgData, palette, range)

            else
                return love.image.newImageData(realpath)
    else
        assert(false)
        -- print 'no ext'
        return love.image.newImageData(realpath)

    return nil


get_video = (path) ->
    if found = search('', path)
        return found
    return get_binary('videos/' .. path)


get_sound = (path) ->
    return get_binary('sounds/' .. path)


get_map = (path) ->
    return get_binary('maps/' .. path)


get_music = (path) ->
    return get_binary('music/' .. path)


load_imageData =  (path) ->
    imgData = image_path(path)
    return imgData


load_image = (path) ->
    love = love
    imgData = load_imageData(path)
    return love.graphics.newImage(imgData)


{
    :load_imageData
    :load_image
    :get_binary
    :get_video
    :get_music
    :get_sound
    :get_image
    :get_map
}

