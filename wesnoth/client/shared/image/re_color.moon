----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

import recolor_image from require'image.utils'

-- get_Color_Range = (cfg) ->
--     res =
--         id:   cfg.id
--         name: cfg.name
--         mid:  cfg.rgb[1]
--         max:  cfg.rgb[2]
--         min:  cfg.rgb[3]
--         rep:  cfg.rgb[4]
--     return res


(img, source_palette_id, color_range_id) ->

    DATA = DATA

    -- image = love.image.newImageData(get_binary(raw_path))
    palette = DATA.Color_Palette[source_palette_id]
    assert(palette)

    -- (require'moon').p palette

    -- print 'die color_range_id ist: <' .. color_range_id .. '>'

    -- for thing in *DATA.Color_Range
    --     print thing

    if number = tonumber(color_range_id)
        color_range_id = number

    range = DATA.Color_Range[color_range_id]
    -- (require'moon').p range
    assert(range)
    -- range = get_Color_Range(range)


    recolor_range = require'image.color_range'
    map_rgb = recolor_range(range, palette)

    return recolor_image(img, map_rgb)


    -- image_cache[path] = love.graphics.newImage(
    --     recolor_image(image, map_rgb) )
