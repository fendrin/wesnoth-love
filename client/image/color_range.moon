----
-- Copyright (C) 2003 - 2018 by David White <dave@whitevine.net>
-- SPDX-License-Identifier: GPL-2.0+

bitwise = require"bit"
import hex2rgb from require"client.image.utils"

----
-- @file
-- Generate ranges of colors, and color palettes.
-- Used e.g. to color HP, XP.


----
-- @param new_range color_range
-- @param old_rgb vector<color_t>
-- @return color_range_map
recolor_range = (new_range, old_rgb) ->

    map_rgb = {}

    new_red, new_green, new_blue = hex2rgb(new_range.mid)
    min_red, min_green, min_blue = hex2rgb(new_range.min)
    max_red, max_green, max_blue = hex2rgb(new_range.max)

    -- Map first color in vector to exact new color
    temp_rgb = old_rgb[1]
    r, g, b  = hex2rgb(temp_rgb)

    reference_avg = math.floor((r + g + b) / 3)

    for old_c in *old_rgb
        old_r, old_g, old_b = hex2rgb(old_c)
        old_avg = math.floor((old_r + old_g + old_b) / 3)

        -- Calculate new color
        new_r = 0
        new_g = 0
        new_b = 0

        if bitwise.band(reference_avg, old_avg) <= reference_avg
            old_ratio = old_avg / reference_avg

            new_r = (old_ratio * new_red   + (1 - old_ratio) * min_red)
            new_g = (old_ratio * new_green + (1 - old_ratio) * min_green)
            new_b = (old_ratio * new_blue  + (1 - old_ratio) * min_blue)
        elseif reference_avg != 255
            old_ratio = (255.0 - old_avg) / (255.0 - reference_avg)

            new_r = (old_ratio * new_red   + (1 - old_ratio) * max_red)
            new_g = (old_ratio * new_green + (1 - old_ratio) * max_green)
            new_b = (old_ratio * new_blue  + (1 - old_ratio) * max_blue)
        else
            -- Should never get here.
            -- Would imply old_avg > reference_avg = 255
            assert(false)

        new_r = math.min(new_r, 255)
        new_g = math.min(new_g, 255)
        new_b = math.min(new_b, 255)

        map_rgb[old_c] = {new_r, new_g, new_b}

    return map_rgb

return recolor_range
