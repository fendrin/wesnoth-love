----
-- This page describes the class for handling location sets and location maps.
-- @classmod Location_set

-- get_variable = require("misc").get_variable
-- set_variable = require("misc").set_variable
-- get_map_size = require("map").get_map_size

----
-- Objects of this class store a set of locations, with some data (boolean true, by default) attached to each of them. It is not possible to associate nil or false to a location.
--
-- There is one main constructor #location_set.create and two auxiliary helper constructors #location_set.of_pairs and #location_set.of_wsl_var. They are provided by the lua/location_set.lua file. All the other functions are methods from the class and they are available through the ':' operator only.
-- @usage local location_set = wesmere.require "lua/location_set.lua"
-- a_set = location_set.create()
-- a_set\insert(17, 42, "something")
-- assert(a_set\get(17, 42) == "something")
-- b_set = location_set.of_pairs(wesmere.get_locations { { "filter_adjacent", { x=17, y=42 } } })
-- a_set\union(b_set)
-- a_set\to_wsl_var "locations"
class Location_Set


    new: (values) =>
        @values = values or {}


    ----
    -- location_set.create
    -- Returns an empty location set.
    -- @treturn Location_set
    @create: () ->
        -- _,h,b = get_map_size!
        -- assert(h + 2 * b < 9000)
        return Location_Set!


    ----
    -- location_set.of_pairs
    -- @treturn Location_set Returns a fresh location set filled by #location_set:of_pairs.
    @of_pairs: (t) ->
        s = Location_Set.create!
        s\of_pairs(t)
        return s


    ----
    -- location_set.of_wsl_var
    -- @return location_set Returns a fresh location set filled by #location_set:of_wsl_var.
    @of_wml_var: (name) ->
        s = Location_Set.create!
        s\of_wml_var(name)
        return s


    index = (x, y) ->
        -- the 2000 bias ensure that the correct x is recovered for negative y
        return x * 16384 + y + 2000


    invscale = 1 / 16384
    revindex = (p) ->
        x = math.floor(p * invscale)
        return x, p - x * 16384 - 2000

    ----
    -- Returns true if the set is empty.
    -- @treturn bool iff empty
    -- @usage some_set = location_set.create()
    -- assert(some_set\empty())
    empty: =>
        return (not next(@values))

    ----
    -- Returns the number of locations in the set.
    -- @treturn number size
    -- @usage some_set\insert(17, 42)
    -- assert(some_set\size! == 1)
    size: =>
        -- sz = 0
        -- for p,v in pairs(@values)
        --     sz += 1
        -- return sz
        return #@values

    ----
    -- Empties the content of the set.
    -- @usage some_set\clear()
    -- assert(not some_set\get(17, 42))
    clear: () =>
        @values = {}

    ----
    -- Returns the data associated to the given location or nil if the location is not in the set.
    -- @usage some_set\insert(17, 42, "something")
    -- assert(some_set\get(17, 42) == "something")
    get: (x, y) =>
        return @values[index(x, y)]

    ----
    -- Associates some data to the given location, or true if there is no data. Previous associated data is lost.
    -- @usage some_set\insert(17, 42)
    -- assert(some_set\get(17, 42))
    insert: (x, y, v) =>
        @values[index(x, y)] = v or true

    ----
    -- Removes the given location from the set.
    -- @usage some_set\remove(17, 42)
    remove: (x, y) =>
        @values[index(x, y)] = nil

    ----
    -- Inserts the locations from the other set, possibly overwriting the associated of data the locations already present.
    -- @tparam location_set self
    -- @tparam location_set s other set
    -- @usage a_set\insert(17, 42, "nothing")
    -- b_set\insert(17, 42, "something")
    -- a_set\union(b_set)
    -- assert(a_set\get(17, 42) == "something")
    union: (s) =>
        values = @values
        for p,v in pairs(s.values)
            values[p] = v

    ----
    -- Calls the given function for all the locations of the other set and uses the returned values to fill the set. Note: the merge order is not stable.
    -- @usage -- merge the elements of s2 into s1 but preserve the old data of s1
    -- function set_union(s1, s2)
    --  s1:union_merge(s2, function(x, y, v1, v2) return v1 or v2 end)
    -- -- remove from s1 the elements of s2
    -- function set_difference(s1, s2)
    -- -- the nested function is called s2:size() times; note: v2 is never nil
    --  s1:union_merge(s2, function(x, y, v1, v2) return nil end)
    union_merge: (s, f) =>
        values = @values
        for p,v in pairs(s.values)
            x, y = revindex(p)
            values[p] = f(x, y, values[p], v)

    ----
    -- Deletes the locations that are not in the other set. Associated data is kept intact if not removed.
    -- @usage a_set\insert(17, 42, "nothing")
    -- b_set\insert(17, 42, "something")
    -- a_set\inter(b_set)
    -- assert(a_set\get(17, 42) == "nothing")
    inter: (s) =>
        nvalues = {}
        for p,_ in pairs(s.values)
            nvalues[p] = @values[p]
        @values = nvalues

    ----
    -- Calls the given function for all the locations of the set and uses the returned values to replace it. Note: the merge order is not stable.
    -- @usage -- compute the intersection of s1 and s2 and put it into s1, but overwrite the data of s1
    -- function set_inter(s1, s2)
    --    s1:inter_merge(s2, function(x, y, v1, v2) return v2 or v1 end)
    -- remove from s1 the elements of s2
    -- function set_difference(s1, s2)
    -- -- the nested function is called s1:size() times; note: v1 is never nil
    --    s1:inter_merge(s2, function(x, y, v1, v2) return not v2 end)
    inter_merge: (s, f) =>
        values = s.values
        nvalues = {}
        for p,v in pairs(@values)
            x, y = revindex(p)
            nvalues[p] = f(x, y, v, values[p])
        @values = nvalues

    ----
    -- Returns a new set containing all the locations of the set for which the given function returns true.
    -- @tparam location_set self
    -- @func f filter
    -- @usage new_set = old_set:filter(function(x, y, v)
    -- d = helper.distance_between(a, b, x, y)
    -- return d <= 5 and v == "not found" )
    -- wesmere.message(string.format("%d traps in the neighborhood of (%d,%d)", new_set:size(), a, b))
    filter: (f) =>
        nvalues = {}
        for p,v in pairs(@values)
            x, y = revindex(p)
            if f(x, y, v) then nvalues[p] = v
        --return setmetatable({ values: nvalues }, locset_meta)
        return Location_Set(nvalues)

    ----
    -- Calls the given function on all the locations of the set. Iteration order is not deterministic. If the order actually matters, the #location_set:stable_iter method should be used instead.
    -- @usage some_set\iter( (x, y, data) -> wesmere.message(string.format("[%d,%d] = %s", x, y, type(data))) )
    iter: (f) =>
        for p,v in pairs(@values)
            x, y = revindex(p)
            f(x, y, v)

    ----
    -- Calls the given function on all the locations of the set. Contrarily to #location_set:iter, the iteration is deterministic and hence safe for networks and replays.
    -- @usage some_set:stable_iter(function(x, y, data) wesmere.message(string.format("[%d,%d] = %s", x, y, type(data))) end)
    stable_iter: (f) =>
        indices = {}
        for p,_ in pairs(@values)
            table.insert(indices, p)
        table.sort(indices)
        for i,p in ipairs(indices)
            x, y = revindex(p)
            f(x, y)

    ----
    -- Inserts all the locations from an array containing pairs (arrays with two elements). Previous content of the set is kept, unless overwritten by the content of the array.
    -- @usage some_set\of_pairs(wesmere.get_locations { { "filter_adjacent", { x:17, y:42 } } })
    -- @usage Can also read in tables with location tables of the form {x: some_number, y: some_number} like what is returned by ai.get_avoid().
    -- some_set\of_pairs(ai.get_avoid())
    -- If any extra data is included in the table for an individual location in the input, it will be put into a table and associated with that location's index in the location_set. Otherwise the data associated with a location's index is "true".
    of_pairs: (t) =>
        values = @values
        for i,v in ipairs(t)
            value_table = {}
            local x_index
            local y_index
            if v.x and v.y
                x_index = "x"
                y_index = "y"
            else
                x_index = 1
                y_index = 2

            for k,val in pairs(v)
                if k ~= x_index and k ~= y_index
                    value_table[k] = val

                if next(value_table)
                    values[index(v[x_index], v[y_index])] = value_table
                else
                    values[index(v[x_index], v[y_index])] = true


    ----
    -- location_set:of_wsl_var
    -- Inserts all the locations from a WSL array. If a container has more than just x and y attributes, the remaining attributes and children are associated to the location as a WSL table. Previous content of the set is kept, unless overwritten by the content of the WSL array.
    -- @usage wesmere.wsl_actions.store_locations { variable="target", { "filter_adjacent", { x=17, y=42 } } }
    -- of_wml_var: (name) =>
    --     values = @values
    --     for i = 0, get_variable(name .. ".length") - 1
    --         t = get_variable(string.format("%s[%d]", name, i))
    --         x, y = t.x, t.y
    --         t.x, t.y = nil, nil
    --         values[index(x, y)] = next(t) and t or true


    ----
    -- @return Returns an array of pairs containing the locations of the set. Associated data are ignored. The order of the locations is not deterministic. If the order actually matters, the #location_set:to_stable_pairs method should be used instead.
    -- @usage size = #(some_set\to_pairs!)
    to_pairs: =>
        res = {}
        @iter( (x, y) -> table.insert(res, { x, y }) )
        return res


    ----
    -- @return Returns an array of pairs containing the locations of the set.
    -- Contrarily to #location_set:to_pairs, the locations are guaranteed to be sorted and hence synchronized over networks and replays.
    to_stable_pairs: =>
        res = {}
        @stable_iter( (x, y) -> table.insert(res, { x, y }) )
        return res


    ----
    -- location_set:to_wsl_var
    -- Fills a WSL array with the content of the set. The order of the elements is safe.
    -- @usage some_set = location_set.of_pairs(wesmere.get_locations { { "filter_adjacent", { x=17, y=42 } } })
    -- some_set\to_wsl_var "locations"
    -- to_wsl_var: (name) =>
    --     i = 0
    --     set_variable(name)
    --     @stable_iter( (x, y, v) ->
    --         set_variable(string.format("%s[%d]", name, i), v) if type(v) == 'table'

    --         set_variable(string.format("%s[%d].x", name, i), x)
    --         set_variable(string.format("%s[%d].y", name, i), y)
    --         i += 1
    --     )


return Location_Set
