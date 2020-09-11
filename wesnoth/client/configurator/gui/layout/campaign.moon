----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

import load_imageData from require'binary'


getColor = (self) ->
    if self.value
        return {0,0,0}
    else
        return {130,130,130}


(campaigns) ->
    things = for id, campaign in  pairs campaigns
        { style: 'listThing', align: 'middle left', group: 'campaign', id: id, type: 'radio',
            text: campaign.name, icon: load_imageData(campaign.icon), background: getColor }

    with things
        .id = 'campaignBox'
        .minwidth = 200
        .width = 200
        .scroll = true
        .type = 'panel'


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
                        flow: 'x'
                        things
                        {
                            flow: 'y'
                            width: 350
                            { type: 'panel', id: 'imagePanel', width: 350, height: 350 }
                            { type: 'panel', width: 350}
                        }
                        { type: 'panel', id: 'descriptionPanel' }
                    }
                    {
                        style: 'dialogFoot'
                        {}
                        { style: 'dialogButton', id: 'closeButton', text: 'Close' }
                        { style: 'dialogButton', id: 'startButton', text: 'Start' }
                    }
                }
            }
            {}
        }
        {}
    }

