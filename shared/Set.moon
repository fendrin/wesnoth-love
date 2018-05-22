
class Set

    new: =>
        @reverse = {}
        @set     = {}


    insert: (value) =>
        unless @reverse[value]
            table.insert(@set, value)
            @reverse[value] = #@set


    remove: (value) =>
        index = @reverse[value]
        if index
            @reverse[value] = nil
            -- pop the top element off the set
            top = table.remove(@set)
            -- if it's not the element that we actually want to remove,
            -- put it back into the set at the index of the element that we
            -- do want to remove, replacing it
            if top != value
                @reverse[top] = index
                @set[index] = top


    contains: (value) =>
        return @reverse[value] != nil
