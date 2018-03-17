----
-- Executed by the love2d engine before all other files.
-- used to configure the moonscript search pathes and loading moonscript.
-- At last we register our config function here which is later called for
-- seting up the engine's parameters.

local paths = {
    love.filesystem.getRequirePath(),
    "lib/?.lua", "lib/?/init.lua",
    "lib/moonscript/?.lua"
}

local search_path = ""
for i, path in ipairs(paths) do
    search_path = search_path .. path
    if i ~= #paths then
        search_path = search_path .. ';'
    end
end

-- First set the lua searchpath of love to our needs,
-- then require moonscript,
-- which registers its own loader (for files with the .moon extension)
-- with the luapathes rewriten for moonscript.
love.filesystem.setRequirePath(search_path)
require"moonscript"

-- Register the love.conf function after requireing moonscript,
-- since the function's file could already miss a lua counterpart.
love.conf = require"love_conf"



-- print("luapath: "       .. package.path)
-- print("love_luapath: "  .. love.filesystem.getRequirePath())
-- print("moonpath: "      .. package.moonpath)
-- print("love_moonpath: " .. package.love_moonpath)
