----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- #textdomain wesnoth-lib
-- ###
-- ### Preferences dialog, Hotkeys page
-- ###
{
-- [layer]

--     [row]
--         grow_factor = 0

--         [column]
--             horizontal_grow = true

--             [grid]

--                 [row]

--                     [column]
--                         grow_factor = 0
--                         border = "all"
--                         border_size = 5

--                         [label]
--                             definition = "default"
--                             label = _ "Categories:"
--                         [/label]
--                     [/column]

--                     [column]
--                         grow_factor = 1
--                         border = "all"
--                         border_size = 5
--                         horizontal_grow = true

--                         [multimenu_button]
--                             id = "hotkey_category_menu"
--                             definition = "default"
--                             maximum_shown = 3
--                         [/multimenu_button]
--                     [/column]

--                 [/row]

--             [/grid]

--         [/column]

--     [/row]

--     [row]
--         grow_factor = 1

--         [column]
--             horizontal_grow = true
--             vertical_alignment = "top"
--             border = "all"
--             border_size = 5

--             [listbox]
--                 id = "list_hotkeys"
--                 definition = "default"
--                 [header]
--                     [row]
--                         ## The Icon column
--                         [column]
--                             grow_factor = 1
--                             horizontal_grow = true
--                             [spacer]
--                                 linked_group = "hotkeys_col_icon"
--                             [/spacer]
--                         [/column]

--                         ## The description column
--                         [column]
--                             grow_factor = 1
--                             horizontal_grow = true
--                             [toggle_button]
--                                 id = "sort_0"
--                                 definition = "listbox_header"
--                                 linked_group = "hotkeys_col_desc"
--                                 label = _ "Action"
--                             [/toggle_button]
--                         [/column]

--                         ## The hotkey column
--                         [column]
--                             grow_factor = 1
--                             horizontal_grow = true
--                             [toggle_button]
--                                 id = "sort_1"
--                                 definition = "listbox_header"
--                                 linked_group = "hotkeys_col_hotkey"
--                                 label = _ "Hotkey"
--                             [/toggle_button]
--                         [/column]

--                         [column]
--                             grow_factor = 1
--                             horizontal_grow = true
--                             [toggle_button]
--                                 id = "sort_2"
--                                 definition = "listbox_header"
--                                 linked_group = "hotkeys_col_type"
--                                 label = _ "game_hotkeys^G"
--                                 tooltip = _ "Available in game"
--                             [/toggle_button]
--                         [/column]

--                         [column]
--                             grow_factor = 1
--                             horizontal_grow = true
--                             [toggle_button]
--                                 id = "sort_3"
--                                 definition = "listbox_header"
--                                 linked_group = "hotkeys_col_type"
--                                 label = _ "editor_hotkeys^E"
--                                 tooltip = _ "Available in editor"
--                             [/toggle_button]
--                         [/column]

--                         [column]
--                             grow_factor = 1
--                             horizontal_grow = true
--                             [toggle_button]
--                                 id = "sort_4"
--                                 definition = "listbox_header"
--                                 linked_group = "hotkeys_col_type"
--                                 label = _ "titlescreen_hotkeys^T"
--                                 tooltip = _ "Available at titlescreen"
--                             [/toggle_button]
--                         [/column]
--                     [/row]
--                 [/header]

--                 [list_definition]
--                     [row]
--                         [column]
--                             horizontal_grow = true
--                             [toggle_panel]
--                                 definition = "default"
--                                 [grid]
--                                     [row]
--                                         [column]
--                                             grow_factor = 0
--                                             border = "all"
--                                             border_size = 5
--                                             horizontal_grow = true
--                                             [image]
--                                                 id = "img_icon"
--                                                 linked_group = "hotkeys_col_icon"
--                                             [/image]
--                                         [/column]

--                                         ## The description column
--                                         [column]
--                                             grow_factor = 1
--                                             horizontal_grow = true
--                                             border = "all"
--                                             border_size = 5
--                                             ## work around 'empty lines have height 0'
--                                             vertical_grow = true
--                                             [label]
--                                                 id = "lbl_desc"
--                                                 definition = "gold_small"
--                                                 linked_group = "hotkeys_col_desc"
--                                                 characters_per_line = 30
--                                             [/label]
--                                         [/column]

--                                         ## The hotkey column
--                                         [column]
--                                             grow_factor = 1
--                                             horizontal_grow = true
--                                             border = "all"
--                                             border_size = 5
--                                             ## work around 'empty lines have height 0'
--                                             vertical_grow = true
--                                             [label]
--                                                 id = "lbl_hotkey"
--                                                 definition = "default"
--                                                 linked_group = "hotkeys_col_hotkey"
--                                             [/label]
--                                         [/column]

--                                         [column]
--                                             grow_factor = 0
--                                             border = "all"
--                                             border_size = 5
--                                             [label]
--                                                 id = "lbl_is_game"
--                                                 definition = "default"
--                                                 linked_group = "hotkeys_col_type"
--                                             [/label]
--                                         [/column]

--                                         [column]
--                                             grow_factor = 0
--                                             border = "all"
--                                             border_size = 5
--                                             [label]
--                                                 id = "lbl_is_editor"
--                                                 definition = "default"
--                                                 linked_group = "hotkeys_col_type"
--                                             [/label]
--                                         [/column]

--                                         [column]
--                                             grow_factor = 0
--                                             border = "all"
--                                             border_size = 5
--                                             [label]
--                                                 id = "lbl_is_titlescreen"
--                                                 definition = "default"
--                                                 linked_group = "hotkeys_col_type"
--                                             [/label]
--                                         [/column]
--                                     [/row]
--                                 [/grid]
--                             [/toggle_panel]
--                         [/column]
--                     [/row]
--                 [/list_definition]
--             [/listbox]
--         [/column]
--     [/row]

--     [row]
--         grow_factor = 0
--         [column]
--             horizontal_grow = true

--             [grid]
--                 [row]
--                     grow_factor = 1
--                     [column]
--                         grow_factor = 0
--                         border = "all"
--                         border_size = 5
--                         horizontal_grow = true
--                         [button]
--                             label = _"Add Hotkey"
--                             id = "btn_add_hotkey"
--                         [/button]
--                     [/column]

--                     [column]
--                         grow_factor = 0
--                         border = "all"
--                         border_size = 5
--                         horizontal_grow = true
--                         [button]
--                             label = _"Clear Hotkey"
--                             id = "btn_clear_hotkey"
--                         [/button]
--                     [/column]

--                     [column]
--                         grow_factor = 1
--                         border = "all"
--                         border_size = 5
--                         horizontal_alignment = "right"
--                         [button]
--                             label = _"Defaults"
--                             id = "btn_reset_hotkeys"
--                         [/button]
--                     [/column]
--                 [/row]
--             [/grid]
--         [/column]
--     [/row]

-- [/layer]
}
