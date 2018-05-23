----
-- Executed by the love2d engine before all other files.
-- used to configure the moonscript search pathes and loading moonscript.
-- At last we register our config function here which is later called for
-- seting up the engine's parameters.
local love = love

local search_path = love.filesystem.getRequirePath()
local paths = {
    "lib",
    "lib/moonscript",
    "client/lib",
    "server/lib",
    "shared"
}

for i, path in ipairs(paths) do
    if i == 1 then
        search_path = search_path .. ';'
    end
    search_path = search_path .. path .. "/?.lua;"
    search_path = search_path .. path .. "/?/init.lua"
    if i ~= #paths then
        search_path = search_path .. ';'
    end
end

-- First set the lua searchpath of love to our needs, then require moonscript,
-- which registers its own loader (for files with the .moon extension)
-- with the luapathes rewriten for moonscript.
love.filesystem.setRequirePath(search_path)
require"moonscript"

-- Register the love.conf function after requireing moonscript,
-- since the function's file could already miss a lua counterpart.
love.conf = require"love_conf"
