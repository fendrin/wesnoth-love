-- app =  require"pl.app"
-- args = require"launcher.cmd_line_args"
-- logger = logger
-- log = logger"cmd_line"
argparse = require"argparse"

load_args = (arg) ->

    parser = argparse!
    parser\option("--debug")
    parser\argument("path", "path to love data")\args('?')
    args = parser\parse(arg)

    -- config = {}
    -- if log_domain = args.debug
    --     -- log.warn"enabling debug output for #{log_domain}"
    --     log_config = {
    --         [log_domain]: true
    --     }
    --     -- log.set_config(log_config)

    -- for item, param in pairs args
        -- log.debug(item .. '=' .. param)

    return args

    -- config = {}
    -- for category  in *args
    --     for param in *category
    --         if param.arg
    --             if param.long
    --                 config[param.long]  = true
    --             if param.short
    --                 config[param.short] = true

    -- -- @todo handle parameters
    -- -- flags, parameters = app.parse_args(arg, config)
    -- flags, _ = app.parse_args(arg, config)

    -- if flags.help
    --     for category in *args
    --         print category.description
    --         for param in *category
    --             line = ""
    --             if param.arg
    --                 if param.short
    --                     line ..= "-#{param.short} "
    --                 if param.long
    --                     line ..= "--#{param.long} "
    --             if param.description
    --                 line ..= "     " .. param.description
    --             print line

    -- return {
    --     resolution: flags.resolution
    --     r: flags.r
    -- }


return load_args
