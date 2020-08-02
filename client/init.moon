----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

send_request = require"client.send_request"

screenID = "prestart"
require"shared.screen"(screenID)

export gameState = {
    board: {
        -- todo fix the hardcoded map size
        units: (require"wesnoth.utils.unit_map")(30,30)
        sides: {}
    }
}
send_request{
    request_name: "clientReady"
}
