recolor_range = require"client.color_range"
Set           = require"shared.Set"

----
-- @return std::vector<color_t>
-- @param color_range cr
palette = (cr) ->

    temp = {}
    res  = {}
    clist = Set!

    -- Use blue to make master set of possible colors
    for i = 255, 0
        j = 255 - i

        table.insert(temp, {0,0,i})
        table.insert(temp, {j,j,255})

    -- Use recolor function to generate list of possible colors.
    -- Could use a special function, would be more efficient,
    -- but harder to maintain.
    cmap = recolor_range(cr, temp)
    for cm in *cmap
        table.insert(clist, cm[2])

    table.insert(res, cmap[{0,0,255}])

    for cs in *clist
        if cs != res[1] and !cs.null() and cs != {255,255,255}
            table.insert(res, cs)

    return res


return palette
