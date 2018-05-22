app =  require"pl.app"
args = require"launcher.cmd_line_args"

load_args = (arg) ->

    config = {}
    for category  in *args
        for param in *category
            if param.arg
                if param.long
                    config[param.long]  = true
                if param.short
                    config[param.short] = true

    -- @todo handle parameters
    -- flags, parameters = app.parse_args(arg, config)
    flags, _ = app.parse_args(arg, config)

    if flags.help
        for category in *args
            print category.description
            for param in *category
                line = ""
                if param.arg
                    if param.short
                        line ..= "-#{param.short} "
                    if param.long
                        line ..= "--#{param.long} "
                if param.description
                    line ..= "     " .. param.description
                print line

    return {
        resolution: flags.resolution
        r: flags.r
    }


return load_args
