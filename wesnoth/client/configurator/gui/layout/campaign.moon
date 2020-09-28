----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

import load_imageData from require'binary'

-- todo fix in luigi
bronze = { 0.734375, 0.6875, 0.53125 }
bronze256 = { 0.734375 * 256, 0.6875 * 256, 0.53125 * 256 }

getColor = (self) ->
    if self.value
        return {0, 0, 0}
    else
        return {130, 130, 130}


(campaigns) ->
    things = for id, campaign in  pairs campaigns
        { style: 'listThing', align: 'middle left', group: 'campaign', id: id, type: 'radio',
            text: campaign.name, icon: load_imageData(campaign.icon), background: getColor, size: 16 }

    first = campaigns[things[1].id]
    campaign_image = load_imageData(first.image)

    with things
        .id = 'campaignBox'
        .minwidth = 250
        .width = 250
        .scroll = true
        .type = 'panel'

    things[1].value = true

    {
        {}
        {
            flow: 'x'
            height: 720
            {}
            {
                style: 'win'
                width: 1280, height: 720
                {
                    {
                        style: 'dialogHead'
                        height: 50
                        { type: 'label', height: 50, text: 'Play a Campaign', size: 22, color: bronze, align: 'left, middle' }
                    }
                    {
                        type: 'panel'
                        flow: 'x'
                        things
                        { width: 10 }
                        {
                            flow: 'y'
                            { type: 'label', height: 50, text: first.name, id: 'campaignName', size: 24, color: {0.7, 0.7, 0.7} }
                            {
                                flow: 'x'
                                {
                                    outline: bronze256
                                    type: 'panel'
                                    id: 'campaignImage'
                                    background: {0,0,0}
                                    icon: campaign_image
                                    width: campaign_image\getWidth! + 1.5
                                    height: campaign_image\getHeight! + 1.5
                                }
                                { width: 10 }
                                { type: 'panel', id: 'campaignDescription', text: first.description, wrap: true, size: 16}
                            }
                        }
                    }
                    {
                        style: 'dialogFoot'
                        {}
                        { style: 'dialogButton', id: 'closeButton', text: 'Close' , color: bronze }
                        { style: 'dialogButton', id: 'startButton', text: 'Start' , color: bronze }
                    }
                }
            }
            {}
        }
        {}
    }

