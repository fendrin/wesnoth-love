----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

left = {
    width: "auto"
    {}
    {
        height: "auto"
        flow: 'x'
        { type: 'label', text: 'Resolution:', width: 150, align: "right, top", height: false, color: {255,255,255} }
        {
            {
                type: 'stepper'
                id: 'resolution'
                status: "Change the game resolution"
                width: 330
                index: 5
                { value: {1280, 720},  text: "1280 x 720 (16:9)"   }
                { value: {1280, 800},  text: "1280 x 800 (16:10)"  }
                { value: {1280, 960},  text: "1280 x 960 (4:3)"    }
                { value: {1280, 1024}, text: '1280 x 1024 (5:4)'   }
                { value: {1400, 1050}, text: '1400 x 1050 (4:3)'   }
                { value: {1440, 900},  text: '1440 x 900 (16:10)'  }
                { value: {1600, 900},  text: '1600 x 900 (16:9)'   }
                { value: {1600, 1200}, text: '1600 x 1200 (4:3)'   }
                { value: {1680, 1050}, text: '1680 x 1060 (16:10)' }
                { value: {1920, 1080}, text: "1920 x 1080 (16:9)"  }
                { value: {1920, 1200}, text: "1920 x 1200 (16:10)" }
                { value: {1920, 1440}, text: "1920 x 1440 (4:3)"   }
                { value: {2048, 1152}, text: "2048 x 1152 (16:9)"  }
                { value: {2560, 1080}, text: "2560 x 1080 (21:9)"  }
                { value: {2560, 1440}, text: "2560 x 1440 (16:9)"  }
                { value: {2560, 1600}, text: "2560 x 1600 (16:10)" }
                { value: {3440, 1440}, text: "3440 x 1440 (21:9)"  }
                { value: {3840, 1600}, text: "3840 x 1600 (21:9)"  }
                { value: {3840, 2160}, text: "3840 x 2160 (16:9)"  }
            }
            {
                flow: 'x'
                {
                    type: "check", text: "Full screen", id: "fullscreen"
                    height: 40, width: 170
                    status: "Toggle between fullscreen and window mode"
                }
                {
                    {
                        id: "mode_desktop", type: 'radio', group: 'fullscreentype'
                        text: 'Desktop', status: "borderless fullscreen windowed"
                    }
                    {
                        id: "mode_exclusive", type: 'radio', group: 'fullscreentype'
                        text: 'Exclusive', status: 'change display mode'
                    }
                }
            }
        }
    }
    {}
    {
        flow: 'x'
        { type: 'label', text: 'Font Scaling:', width: 150, height: false, align: "right, middle", color: {255,255,255} }
        {
            type: 'slider'
            id: 'scaling_slider'
            status: "Set the scaling factor of fonts"
            width: 330
        }
    }
    {}
    {
        flow: 'x'
        { type: 'label', text: 'Theme:', width: 150, height: false, align: "right, middle", color: {255,255,255}}
        {
            type: 'stepper'
            id: 'choose_theme'
            status: "Change the in-game theme"
            width: 330
            { value: "dark",    text: 'Dark', status: "dark evil theme"}
            { value: "light",   text: 'Light' }
            { value: "wesnoth", text: 'Wesnoth' }
        }
    }
    {
        flow: 'x'
        { type: 'label', text: 'Style:', width: 150, height: false, align: "right, middle", color: {255,255,255}}
        {
            type: 'stepper'
            id: 'choose_style'
            status: "Change the in-game style"
            width: 330
            { value: "default", text: 'Default' }
        }
    }
    {}
}

right = {
    {}
    { type: "check", text: "Animate map", id: "animate_terrains"
        status: "Display animated terrain graphics" }
    { type: "check", text: "Animate water", id: "animate_water"
        status: "Display animated water graphics (can be slow)" }
    {}
    { type: "check", text: "Show unit standing animations", id: "animate_units_standing"
        status: "Continuously animate standing units on the battlefield" }
    { type: "check", text: "Show unit idle animations", id: "animate_units_idle"
        status: "Play short random animations for idle units" }
    {
        flow: 'x'
        height: "auto"
        { type: 'label', text: 'Frequency:', width: 150, height: false,
            align: "right, middle", color: {255,255,255} }
        {
            flow: 'x'
            type: 'stepper'
            id: 'idle_anim_frequency'
            status: "Set the frequency of unit idle animations"
            width: 150
            height: "auto"
            { value: 1, text: 1 }
            { value: 2, text: 2 }
            { value: 3, text: 3 }
            { value: 4, text: 4 }
        }
    }
    -- {
    --     flow: 'x'
    --     { type: 'label', text: 'Frequency:' }
    --     {
    --         type: 'slider', id: 'idle_anim_frequency' --, width: false
    --         width: 100
    --         height: 50
    --         status: "Set the frequency of unit idle animations"
    --     }
    -- }
    {}
    { type: "check", text: "Show floating labels", id: "show_floating_labels"
        status: "Show damage and healing amounts above a unit" }
    { type: "check", text: "Show team colors", id: "show_ellipses"
        status: "Show a colored circle around the base of each unit to show which side it is on" }
    {}
    { type: "check", text: "Show grid", id: "show_grid"
        status: "Overlay a grid over the map" }
    {}
}


{
    flow: 'x'
    left
    {width: 40}
    right
}
