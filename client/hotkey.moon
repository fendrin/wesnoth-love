----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

action2key = {
    -- cursor:
    NORTH: 'kp8'
    NORTH_EAST: 'kp9'
    NORTH_WEST: 'kp7'

    SOUTH: 'kp2'
    SOUTH_EAST: 'kp3'
    SOUTH_WEST: 'kp1'

    EAST: 'kp6'
    WEST: 'kp4'

    scroll_up:   "w"
    scroll_down: "s"
    scroll_east: "a"
    scroll_west: "d"

    quit_game:   "escape"

    end_turn: "end"
}

-- key2action = {}

-- for action, key in ipairs(action2key)
--     key2action[key] = action

return action2key
