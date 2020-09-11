----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- @ file function that transforms a table into moonscript code
-- for now only keys, no list elements are supported

indent_size = 4
indent = ''
for i = 1, indent_size
    indent ..= ' '

level2space = (level) ->
    space = ''
    for i=1, level
        space ..= indent
    return space

level = 1
table2moon = (tab) ->
    str = '{\n'

    space = level2space(level)

    for key, value in pairs tab
        str ..= space
        str ..= "#{key}: "

        switch type(value)
            when 'table'
                level += 1
                str ..= table2moon(value)
                level -= 1
            when 'string'
                str ..= "'#{value}'\n"
            else
                str ..= "#{value}\n"

    space = level2space(level - 1)
    str ..= '\n' .. space
    str ..= '}\n'

    return str


return table2moon

