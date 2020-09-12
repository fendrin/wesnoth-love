----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+
-- assert(false)
-- send_request = require"client.send_request"

-- screenID = "prestart"

-- export loging = (require"utils.log")"client"
-- log = loging"client/init"



-- export gameState = {
--     board: {
--         -- todo fix the hardcoded map size
--         units: (require"wesnoth.utils.unit_map")(30,30)
--         sides: {}
--     }
-- }



-- send_request{
--     request_name: "clientReady"
-- }

-- (config) ->
--     assert(config)
--     log.info"Client started"
--     screenID = "local"
--     require"client.shared.screen"(screenID)
