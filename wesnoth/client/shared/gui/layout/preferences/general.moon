----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- #textdomain wesnoth-lib
--
-- Preferences dialog, General page
--
{
    {}
    {
        flow: 'x'
        {
            type: 'label', text: "Scroll speed:", width: 150, align: "right, top"
            height: false, color: {255,255,255}
        }
        {
            type: "slider"
            width: 330
            id: "scroll_speed"
            status: "Change the speed of scrolling around the map"
        }
    }
    {
        id: "turbo_toggle"
        type: "check"

        text: "Accelerated speed"
        status: "Make units move and fight faster"
    }
    {
        type: "check"
        id: "skip_ai_moves"
        text: "Skip AI moves"
        status: "Do not animate AI units moving"
    }
    -- ( _ "Speed:")
    {
        type: "slider"
        status: "Units move and fight speed"
    }


    {}--     {_GUI_PREFERENCES_SPACER_ROW}
--             [toggle_button]
--                 id = "disable_auto_moves"
--                 label = _ "Disable automatic moves"
--                 tooltip = _ "Do not allow automatic movements at the beginning of a turn"
--             [/toggle_button]
    {
        type: "check"
        id: "show_turn_dialog"
        text: "Turn dialog"
        status: "Display a dialog at the beginning of your turn"
    }
--     [row]
--         [column]
--             border = "all"
--             border_size = 5
--             horizontal_alignment = "left"

--             [toggle_button]
--                 id = "whiteboard_on_start"
--                 label = _ "Enable planning mode on start"
--                 tooltip = _ "Activates Planning Mode on game start"
--             [/toggle_button]
--         [/column]
--     [/row]

--     [row]
--         [column]
--             border = "all"
--             border_size = 5
--             horizontal_alignment = "left"

--             [toggle_button]
--                 id = "whiteboard_hide_allies"
--                 label = _ "Hide allies’ plans by default"
--                 tooltip = _ "Hide allies’ Planning Mode plans in multiplayer games"
--             [/toggle_button]
--         [/column]
--     [/row]

--     [row]
--         [column]
--             border = "all"
--             border_size = 5
--             horizontal_alignment = "left"

    {
        type: "check"--             [toggle_button]
        id: "interrupt_move_when_ally_sighted"
        text: "Interrupt move when an ally is sighted"
        status: "Sighting an allied unit interrupts your unit’s movement"
--
--
    }

--     {_GUI_PREFERENCES_SPACER_ROW}

--     [row]
--         [column]
--             border = "all"
--             border_size = 5
--             horizontal_alignment = "left"

--             [toggle_button]
--                 id = "save_replays"
--                 label = _ "Save replays at the end of scenarios"
--                 tooltip = _ "Save replays of games on victory in all modes and defeat in multiplayer"
--             [/toggle_button]
--         [/column]
--     [/row]

--     [row]
--         [column]
--             border = "all"
--             border_size = 5
--             horizontal_alignment = "left"
    {
        type: "check"
--             [toggle_button]
        id: "delete_saves"
        text: "Delete auto-saves at the end of scenarios"
        status: "Delete previous auto-saves on victory in all modes and defeat in multiplayer"
--             [/toggle_button]
    }
    {}
--         [/column]
--     [/row]

--     [row]
--         [column]
--             horizontal_grow = true
--             {_GUI_PREFERENCES_CHECKBOX_ALIGN_BORDER}
--             {_GUI_PREFERENCES_MAIN_COMPOSITE_SLIDER
--                 ( _ "Maximum auto-saves:")
--                 max_saves_slider (
--                     minimum_value,maximum_value=0,61
--                     step_size=1
--                     tooltip= _ "Set maximum number of automatic saves to be retained"
--                 )
--             }
--         [/column]
--     [/row]
-- #enddef

-- #define _GUI_PREFERENCES_GENERAL_GRID_2
--     [row]
--         [column]
--             border = "all"
--             border_size = 5
--             horizontal_alignment = "left"

--             [button]
--                 id = cachemg
--                 label = _ "Cache"
--                 tooltip = _ "Manage the game WML cache"
--             [/button]
--         [/column]
--     [/row]
-- #enddef

-- [layer]

--     [row]
--         [column]
--             horizontal_grow = true
--             vertical_alignment = "top"
--             [grid]
--                 {_GUI_PREFERENCES_GENERAL_GRID_1}
--             [/grid]
--         [/column]
--     [/row]

--     [row]
--         [column]
--             horizontal_alignment = "left"
--             vertical_alignment = "bottom"

--             [grid]
--                 {_GUI_PREFERENCES_GENERAL_GRID_2}
--             [/grid]
--         [/column]
--     [/row]

-- [/layer]

-- #undef _GUI_PREFERENCES_GENERAL_GRID_1
-- #undef _GUI_PREFERENCES_GENERAL_GRID_2
}
