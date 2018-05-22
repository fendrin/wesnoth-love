-- ###
-- ### Preferences dialog, Sound page
-- ###
-- #textdomain wesnoth-lib


GUI_SOUND_SLIDER_CONTROL = (TOGGLE_ID, TOGGLE_LABEL, TOGGLE_TOOLTIP, SLIDER_ID, SLIDER_TOOLTIP) -> {
    height: "auto"
    width: "auto"
    {
        type: "check", text: TOGGLE_LABEL, id: TOGGLE_ID
        height: 40, width: false
        status: TOGGLE_TOOLTIP
    }
    {
        height: "auto"
        flow: 'x'
        { type: 'label', text: 'Volume:', width: 150, height: 52, align: "right, middle", color: {255,255,255} }
        {
            type: 'slider', id: SLIDER_ID
            height: 52
            width: 330
            status: SLIDER_TOOLTIP
        }
    }
}

body = {
    -- id: "sound"
    size: 20
    width: "auto"
    height: "auto"
    flow: 'x'
    padding: 20
    {
        -- {}
        GUI_SOUND_SLIDER_CONTROL("sound_toggle_sfx", "Sound effects", "Sound effects on/off",
            "sound_volume_sfx", "Change the sound effects volume")
        {height: 40}
        GUI_SOUND_SLIDER_CONTROL("sound_toggle_music", "Music", "Music on/off",
            "sound_volume_music", "Change the music volume")
        {
            flow: 'x'
            height: "auto"
            { width: 150 }
            {
                type: "check", id: "sound_toggle_stop_music_in_background"
                text: "Pause music on focus loss"
                status: "Pause the music when you switch to any other window"
                with: false
            }
        }
        {}
    }
    { width: 40}
    {
        -- {}
        GUI_SOUND_SLIDER_CONTROL("sound_toggle_bell", "Turn bell",
            "Play a bell sound at the beginning of your turn",
            "sound_volume_bell", "Change the bell volume")
        {height: 40}
        GUI_SOUND_SLIDER_CONTROL("sound_toggle_uisfx", "User interface sounds",
            "Turn menu and button sounds on/off", "sound_volume_uisfx",
            "Change the sound volume for button clicks, etc.")
        {}
    }
}

{

    {
        {}
        -- align: "center, middle"
        {
            flow: 'x'--, width: "auto"
            height: "auto"
            {}
            GUI_SOUND_SLIDER_CONTROL("sound_toggle_audio", "Audio", "Audio on/off",
                "audio_volume_music", "Change the audio master volume")
            {}
        }
        {}
    }
    body
    {}
}
