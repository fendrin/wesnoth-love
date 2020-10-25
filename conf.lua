----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


----
-- @file
-- Executed by the love2d engine before all other files.
-- used to configure the moonscript search pathes and loading moonscript.
-- At last we register our config function here which is later called for
-- seting up the engine's parameters.

-- todo reenable jit after the segmentation fault is fixed
-- todo add link to bug report here
jit.off()

-- this is the bare minimum to load the next file
local shared_path = {
    "wesnoth",
    "wesnoth/shared",
    "wesnoth/shared/lib",
    "wesnoth/shared/lib/moonscript",
    "wesnoth/shared/lib/Penlight/lua"
}
local setRequirePath = require'wesnoth.shared.setRequirePath'
setRequirePath(shared_path)

-- Copy the lualibs (only lpeg for now) into the savedir.
-- This makes sure love2d can find it without relying on os specific mechanisms.
-- This is espacially needed when running in fuse mode, since libs can't be loaded
-- from within zip files.

local system = require'love.system'
local osString = system.getOS()

local srcPath, dstPath
if osString == 'OS X' then
    srcPath = 'wesnoth/shared/lib/macosx/lpeg.so'
    dstPath = 'lib/lpeg.so'
end
if osString == 'Windows' then
    srcPath = 'wesnoth/shared/lib/windows/lpeg.dll'
    dstPath = 'lib/lpeg.dll'
end
if osString == 'Linux' then
    srcPath = 'wesnoth/shared/lib/linux/lpeg.so'
    dstPath = 'lib/lpeg.so'
end

local filesystem = require'love.filesystem'

-- todo take from a global
filesystem.setIdentity('wesnoth')
if not filesystem.getInfo(dstPath) then

    local success
    success = filesystem.createDirectory('lib')
    if not success then
        print('could not create lib dir')
    end

    local container = 'data'
    local data, error = filesystem.read(container, srcPath)
    if not data then
        print(error)
    else
        local message
        success, message = filesystem.write(dstPath, data)
        if not success then
            print(message)
        end
    end
end

-- First set the lua searchpath of love to our needs, then require moonscript,
-- which registers its own loader (for files with the .moon extension)
-- with the luapathes rewriten for moonscript.
filesystem.setCRequirePath('lib/??')
require"moonscript"

-- Register the love.conf function after requireing moonscript,
-- since the function's file could already miss a lua counterpart.
require"client.conf"

