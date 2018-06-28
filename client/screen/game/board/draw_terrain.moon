love = love
get  = require"filesystem"

local grass, water, otherwater, hills, mountain, sand, forest, forestedHills, castle, keep, village

with love.graphics
    grass =      .newImage(get.assets("data/core/images/terrain/grass/green.png"))
    water =      .newImage(get.assets("data/core/images/terrain/water/ocean-tile.png"))
    otherwater = .newImage(get.assets("data/core/images/terrain/water/coast-tile.png"))
    hills =      .newImage(get.assets("data/core/images/terrain/hills/regular.png"))
    mountain =   .newImage(get.assets("data/core/images/terrain/mountains/basic-tile.png"))
    sand =       .newImage(get.assets("data/core/images/terrain/sand/desert.png"))
    forestedHills = .newImage(get.assets(
        "data/core/images/terrain/forest/forested-deciduous-summer-hills-tile.png"))
    forest =     .newImage(get.assets("data/core/images/terrain/forest/deciduous-summer-tile.png"))
    castle =     .newImage(get.assets("data/core/images/terrain/castle/castle-tile.png"))
    keep =       .newImage(get.assets("data/core/images/terrain/castle/keep-tile.png"))
    village =    .newImage(get.assets("data/core/images/terrain/village/human-tile.png"))

draw_terrain = (terrain, x_pos, y_pos) ->
    x_pos = math.floor(x_pos)
    y_pos = math.floor(y_pos)
    with love.graphics
        switch terrain
            when "Gd^Es", "Re^Es", "Rd^Es", "Gg^Es", "Gd", "Gg", "Gs","Re", "Rd", "Rr", "Gs^Es", "Ww^Bw/", "Rb", "Gg^Efm", "Rb^Es"
                .draw(grass, x_pos, y_pos)
            when "Wo"
                .draw(water, x_pos, y_pos)
            when "Ww"
                .draw(otherwater, x_pos, y_pos)
            when "Hh"
                .draw(hills, x_pos, y_pos)
            when "Mm"
                .draw(mountain, x_pos, y_pos)
            when "Ds"
                .draw(sand, x_pos, y_pos)
            when "Gd^Fds", "Gll^Fds", "Gs^Fds", "Re^Fds", "Gg^Fet", "Gs^Fdw"
                .draw(grass, x_pos, y_pos)
                .draw(forest, x_pos, y_pos)
            when "Hh^Fds"
                .draw(forestedHills, x_pos, y_pos)
            when "Ch", "Ce", "Cv", "Ce^Es"
                .draw(castle, x_pos, y_pos)
            when "Kh", "Ke", "Kv"
                .draw(keep, x_pos, y_pos)
            when "Gd^Vhc", "Gg^Vht", "Hh^Vhh", "Gg^Vh", "Rr^Vhc", "Gs^Vhc",  "Gs^Vh",  "Gs^Vht", "Re^Vhc", "Gg^Ve", "Gs^Ve"
                .draw(village, x_pos, y_pos)
            -- else
            --     .printf(terrain, x_pos, y_pos, tile_w, "center")
        -- draw_terrain_code = true
        if draw_terrain_code
            .printf(terrain, x_pos, y_pos, 54, "center")


return draw_terrain
