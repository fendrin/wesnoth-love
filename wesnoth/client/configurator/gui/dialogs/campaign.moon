----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


loging = loging
log    = loging"gui"

dialog = require"gui.dialog"


campaign = (handler, campaigns) ->

    import load_imageData from require'binary'

    campaign_builder = require"gui.layout.campaign"

    campaign_layout = campaign_builder(campaigns)
    dlg = dialog(campaign_layout)

    with dlg
        .closeButton\onPress( (event) ->
            dlg\hide!
            handler! )
        .startButton\onPress( (event) ->
            dlg\hide!
            handler(.campaign.selected.id) )

        .campaign\onChange( ->
            .imagePanel.icon       = load_imageData(campaigns[.campaign.selected.id].image)
            .descriptionPanel.text = campaigns[.campaign.selected.id].description
        )

    log.debug"campaign dialog created"
    return dlg


return campaign

