----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

config_file_path = 'config.moon'


love = love
stringx = require'pl.stringx'
table2moon = require'shared.table2moon'
loger = require'shared.log'
loging = loger("some")
log = loging'filesystem'

import getRequirePath, read, write, remove,
    getDirectoryItems, getInfo, getRequirePath, getSaveDirectory,
    getWorkingDirectory, getUserDirectory, getSourceBaseDirectory
    getAppdataDirectory, getCRequirePath from love.filesystem


loveGetRequirePath = () ->
    love_path = getRequirePath!
    spacer = '\n * '
    searchpath = ''
    with package
        paths = { {love_path, 'love_lua'}, {.love_moonpath, 'love_moon'} }

        for path in *paths
            searchpath ..= "\n\n Search path for #{path[2]}:" .. spacer
            searchpath ..= stringx.replace(path[1], ';', spacer)
    return searchpath


logPathes = () ->
    with log
        .debug('Working Directory: '     .. getWorkingDirectory!    )
        .debug('User Directory: '        .. getUserDirectory!       )
        .debug('Source Base Directory: ' .. getSourceBaseDirectory! )
        .debug('Appdata Directory: '     .. getAppdataDirectory!    )
        .info('Save Directory: '        .. getSaveDirectory!       )
        .debug('C Require Path: '        .. getCRequirePath!        )
        .debug('Lua Require Paths: '     .. loveGetRequirePath!     )


removeFile = (path) ->
    remove(path)


removeConfig = ->
    removeFile(config_file_path)


writeFile = (str, path) ->
    return write(path, str)


readFile = (path) ->
    contents = read(path)
    return contents


loadFile = (path) ->
    log.debug"loading file: #{path}"
    if str = readFile(path)
        log.debug"file content: #{str}"
        moonscript = require"moonscript"
        file_fun, err = moonscript.loadstring(str)
        unless file_fun
            log.error"Error loading file at #{path}: #{err}"
            return nil
        else
            config = file_fun!
            return config
    else
        return nil


loadConfig = ->
    return loadFile(config_file_path)


writeTable = (cfg, path) ->
    str = table2moon(cfg)
    writeFile(str, path)


writeConfig = (cfg) ->
    writeTable(cfg, config_file_path)


deleteLogs = () ->
    if getInfo("log")
        log_files = getDirectoryItems('log')
        for log_file in *log_files
            remove(log_file)


install = (file) ->
    file\open("r")
	data = file\read!

    file_path = file\getFilename!
    file_name = file_path\match("^.+/(.+)$")

    path = file_name
    success, message = writeFile(data, path)
	if success
        log.info("File geschrieben")
        return true
    else
        log.warn("error: #{message}")
        return false


{
    :install
    :logPathes
    :deleteLogs
    getRequirePath: loveGetRequirePath
    :readFile
    :writeTable
    :loadFile
    :removeConfig
    :loadConfig
    :writeConfig
}

