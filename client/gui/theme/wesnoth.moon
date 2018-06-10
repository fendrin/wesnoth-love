----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

RESOURCE = "assets/themes/wesnoth/"
ROOT     = (...)\gsub('[^.]*.[^.]*$', '')

return (config) ->
    config = config or {}
    config.resources = config.resources or RESOURCE
    config.backColor = config.backColor or {  40,  40,  40 }
    config.lineColor = config.lineColor or {  60,  60,  60 }
    config.textColor = config.textColor or { 240, 240, 240 }
    config.highlight = config.highlight or { 0x00, 0x5c, 0x94 }
    return require(ROOT .. 'engine.alpha')(config)
