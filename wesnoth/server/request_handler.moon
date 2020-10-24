----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

loging = loging
log        = loging"server"
controller = (require"wesnoth").controller
wesnoth    = (require"wesnoth").wesnoth


request_handler = (request) ->

    DATA = DATA
    switch request.request_name

        when 'objectives'
            wesnoth.show_sides_objectives(1)
            return

        when "connect"
            log.info'connect request handler'
            config = {
                command_name: 'data'
                Campaign:      DATA.Campaign
                Tip:           DATA.Tip
                Game_Config:   DATA.Game_Config
                Binary_Path:   DATA.Binary_Path
                Color_Palette: DATA.Color_Palette
                Color_Range:   DATA.Color_Range
            }
            return {config}

        when "Move"
            log.info"Move request not implemented yet"

        when "startCampaign"
            log.info"startCampaign request"

            controller.load_campaign(request.id)
            data = {
                command_name: 'data'
                Game_Config:   DATA.Game_Config
                Binary_Path:   DATA.Binary_Path
                Color_Palette: DATA.Color_Palette
                Color_Range:   DATA.Color_Range
            }

            state = controller.get_client_state(1)
            setupReady = { command_name: "setupReady" }

            return {data, state, setupReady}

        when "startScenario"
            controller.start_scenario!
            return
        else
            assert(false, "unhandled request: #{request.request_name}")


return request_handler

