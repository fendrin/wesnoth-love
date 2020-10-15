----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


RESOURCE = "assets/themes/wesnoth-highres/"
ROOT     = (...)\gsub('[^.]*.[^.]*$', '')


return (config) ->
    config = config or {}
    config.resources = config.resources or RESOURCE
    config.backColor = config.backColor or {  40/255,  40/255,  40/255 }
    config.lineColor = config.lineColor or {  91/255,  58/255,  41/255 }
    config.textColor = config.textColor or { 210/255, 160/255, 100/255 }
    config.highlight = config.highlight or {     0.5,     0.5,     0.5 }
    return require(ROOT .. 'engine.alpha')(config)

