----
-- lifted from leafo.net
-- @classmod HasGetters


class HasGetters
    getters: {}


    __inherited: (cls) =>
        old_init = cls.__init
        cls.__init = (...) =>
            old_init @, ...

            mt = getmetatable @
            old_index = mt.__index


            mt.__index = (name) =>

                old_index_is_function = type(old_index) == "function"

                if name == "getters" -- prevent endless loop
                    if old_index_is_function
                        return old_index @, "getters"
                    else
                        return rawget(old_index, "getters")

                getters = if old_index_is_function
                    old_index @, "getters"
                else rawget(old_index, "getters")

                getter_value = switch type(getters)
                    when "function"
                        getters @, name
                    when "table"
                        if getter = getters[name]
                            getter @
                    else nil

                return getter_value unless getter_value == nil

                if old_index_is_function
                    old_index @, name
                else
                    rawget(old_index, name)
