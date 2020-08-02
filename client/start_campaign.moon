----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

send_request = require"client.send_request"

return (id) ->
    request = {
        request_name: "startCampaign"
        :id
    }

    send_request(request)
