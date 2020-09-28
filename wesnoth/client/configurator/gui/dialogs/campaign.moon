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

            selected = campaigns[.campaign.selected.id]

            image = load_imageData(selected.image)
            .campaignName.text = selected.name
            .campaignImage.icon       = image
            .campaignImage.height     = image\getHeight! + 1.5
            .campaignImage.width      = image\getWidth!  + 1.5
            .campaignImage\reshape!
            .campaignDescription.text = selected.description
        )

    log.debug"campaign dialog created"
    return dlg


return campaign

