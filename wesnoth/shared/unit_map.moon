----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+



dir = (...)\match"(.-)[^%.]+$"
-- moon = require "moon"

Loc = require "Location"
-- Unit = require "server.wesnoth.Unit"
-- HasGetters = require "HasGetters"


class UnitMap -- extends HasGetters

    ----
    -- Iterator over all units on the board.
    -- The order is based on growing internal id numbers.
    -- Although units may have left the board and thus the nth returny is not bound to the internal id n.
    -- @function iter
    -- @tparam UnitMap self
    -- @treturn func the iterator
    iter: =>
        i = 0
        return ->
            local unit
            while unit == nil
                i += 1
                return nil if i > #@ids
                unit = @get_unit_by_internal_id(i)
            return unit

    drop_unit: (cfg) =>

    ----
    -- Getter for a unit when you know its id.
    -- @function get_unit
    -- @string id the requested unit's id
    -- @treturn Unit the
    get_unit: (id) =>
        assert(id, "UnitMap.get_unit: Missing argument 'id'")
        if loc = @get_loc(id)
            return @get_unit_at(loc.x, loc.y)


    get_unit_by_internal_id: (number) =>
        assert(number)
        assert(type(number) == "number")
        if id = @ids[number]
            return @get_unit(id)
        else return nil


    -- getters: (key) =>
    --     print "the key is #{key}"
    --     key_type = type(key)
    --     switch key_type
    --         when "number"
    --             return @get_unit_by_internal_id(key)
    --         when "string"
    --             if key != "get_unit"
    --                 return @get_unit(key)
    --         else
    --             error "UnitMap.getters: unsupported getter key type: #{key_type}, value #{key}"


    new: (width, height) =>
        @ids = {}
        @units = {} -- id -> location
        @board = {} -- coordinates -> Unit
        @width = width
        @height = height
        for w = 1, width
            @board[w] = {}


    ----
    -- @function place_unit
    -- @tparam Unit unit the unit to place on the board
    -- @tparam x
    -- @tparam y
    -- @treturn bool
    place_unit: (unit, x, y) =>
        assert(@)
        assert(unit, "Missing argument 'unit'")

        -- type_of_unit = moon.type(unit)
        -- Unit = require "#{dir}.Unit"
        -- assert(type_of_unit == Unit, "Unit argument is not a Unit object but #{type_of_unit}.")

        assert(x, "Missing argument 'x'")
        assert(y, "Missing argument 'y'")
        id = unit.id
        assert(id)

        old_unit = @units[id]
        if old_unit
            -- error "Tried to add a unit with already known id: #{id}"
            @remove_unit(id)

        if occupied = @get_unit_at(x, y)
            -- error "Hex field at #{x},#{y} is already occupied."
            return false
            --- @TODO think about error or false or occupied
        else
            table.insert(@ids, id)
            @units[id] = Loc(x,y)
            @board[x][y] = unit
            return true

        assert(false) -- should not be reached.


    ----
    -- Return a unit's location.
    -- @function get_loc
    -- @string id
    -- @treturn Location of the unit with the given id
    get_loc: (id) =>
        return @units[id]


    ----
    -- @function remove_unit
    -- @tparam UnitMap self
    -- @string id The id of the unit to remove.
    remove_unit: (id) =>
        assert(id, "UnitMap.remove_unit: Missing 'id' argument")

        if loc = @get_loc(id)
            return @clear_location(loc.x,loc.y)
        else
            return false


    ----
    -- Returns the unit at the given location. This leaves the unit untouched at place.
    -- @function get_unit_at
    -- @number x
    -- @number y
    -- @treturn Unit
    get_unit_at: (x, y) =>
        -- todo think about making nil inputs an error
        return nil unless x
        return nil unless y

        -- error "UnitMap.get_unit_at: Y-coordinate is offmap: #{y} - #{@height}" if y < 1 or y > @height
        return nil if y < 1 or y > @height
        -- error "UnitMap.get_unit_at: Y-coordinate is offmap: #{x} - #{@width}"  if x < 1 or x > @width
        return nil if x < 1 or x > @width
        return @board[x][y]


    ----
    -- @function clear_location
    -- @number x
    -- @number y
    -- @treturn bool|Unit iff a unit was removed
    clear_location: (x, y) =>
        if unit = @get_unit_at(x, y)
            @board[x][y] = nil
            @units[unit.id] = nil
            return unit
        else
            return false

