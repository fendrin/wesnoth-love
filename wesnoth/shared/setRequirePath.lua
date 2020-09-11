----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- this file is written in lua so that the search paths can be altered before moonscript is required

local function loveSetRequirePath (paths)

    -- disable not love related search paths to avoid confusion
    package.path = ''
    package.moonpath = ''

    package.love_moonpath = ''
    local search_path = ''

    for i, path in ipairs(paths) do

        if not i == 1 then
            package.love_moonpath = package.love_moonpath .. ';'
        end

        package.love_moonpath = package.love_moonpath .. path .. "/?.moon;"
        package.love_moonpath = package.love_moonpath .. path .. "/?/init.moon"

        search_path = search_path .. path .. "/?.lua;"
        search_path = search_path .. path .. "/?/init.lua"

        if i ~= #paths then
            search_path = search_path .. ';'
            package.love_moonpath = package.love_moonpath .. ';'
            -- end
        end
    end

    love.filesystem.setRequirePath(search_path)
end


return loveSetRequirePath

