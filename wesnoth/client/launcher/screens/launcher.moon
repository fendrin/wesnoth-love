----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


-- todo get rid of love inside here
love   = love
loging = loging
log    = loging"screen"
assets = require'assets'

engine = require'engine'

launcher_menu = require"gui.dialogs.launcher_menu"
yes_no        = require"gui.dialogs.yes_no"

Screen = require'screen.Screen'


class Launcher extends Screen

    menu_dlg_handler = (action) =>
        @next_action = action


    addon_handler = (confirmed) =>
        if confirmed
            print'addon confirmed'
            @install_confirmed = true


    new: (director) =>
        @menu = launcher_menu( (action) -> menu_dlg_handler(@, action) )
        @addon_dlg = yes_no("Confirm Addon Install",
            "Do you want to install the addon in question?",
            (action)-> addon_handler(@, action))
        @next_action = nil
        @install_confirmed = false
        with assets.images
            @background = love.graphics.newImage(.background)
            @logo       = love.graphics.newImage(.logo)

        log.debug"launcher_screen.new"
        super(director)


    draw: =>
        engine.drawBackground(@background)
        engine.drawBackground(@logo)
        super!


    keypressed: (key) =>
        switch key
            when 'escape'
                engine.quit(0)


    open: =>
        engine.pointer2dialog(@menu, "launcherMenu")


    close: =>
        @menu\hide!


    filedropped: (file) =>
        -- Lua pattern docs at http://www.lua.org/manual/5.1/manual.html#5.4.1
        fileExt = (filename) -> return filename\match("(%.%w+)$") or ""
        -- ext = FileData:getExtension( )
        print("Content of " .. file\getFilename! .. ' is')
        path = file\getFilename!
        addon_extension = '.wesnoth'
        file_extension  = fileExt(path)
        print "the extension is #{file_extension}"
        if addon_extension == file_extension
            @addon_file = file
            print "we have a match"
            @addon_dlg\show!


    update: (dt) =>
        -- return unless next_action
        switch @next_action
            when 'feedback'
                -- todo take from config
                engine.openURL'https://forums.wesnoth.org/viewtopic.php?f=13&t=53148'
            when "local"
                cfg = { mode: 'configurator', server: 'local' }
                engine.writeConfig(cfg)
                engine.restart!
            when "quit"
                engine.quit(0)
            when "preferences"
                @director\activate("preferences")

        @next_action = nil

        if @install_confirmed
            engine.install(@addon_file)
            @install_confirmed = false
            @addon_file = nil

