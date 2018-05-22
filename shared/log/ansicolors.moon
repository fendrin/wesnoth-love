make_color = (value) ->
    return string.char(27) .. '[' .. tostring(value) .. 'm'

colors =
    -- attributes
    reset: 0
    clear: 0
    bright: 1
    dim: 2
    underscore: 4
    blink: 5
    reverse: 7
    hidden: 8

    -- foreground
    black: 30
    red: 31
    green: 32
    yellow: 33
    blue: 34
    magenta: 35
    cyan: 36
    white: 37

    -- background
    onblack: 40
    onred: 41
    ongreen: 42
    onyellow: 43
    onblue: 44
    onmagenta: 45
    oncyan: 46
    onwhite: 47


for color, value in pairs(colors)
    colors[color] = make_color(value)

return colors

-- And here's some ways you can use it:
-- require "ansicolors"
-- print(ansicolors.red .. 'hello from the Red world!' .. ansicolors.reset)
-- clear is a synonym for reset
-- print(ansicolors.blue .. 'go blue!' .. ansicolors.clear)
-- print(ansicolors.underscore .. colors.yellow .. colors.onblue ..
--     'crazy stuff' .. ansicolors.reset)
