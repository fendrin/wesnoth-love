----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

-- todo get rid of love
love  = love
fs    = love.filesystem

color = require"#{...}.ansicolors"

log_color =
    error: color.red
    warn:  color.yellow
    info:  color.green
    debug: color.blue


log_dir  = "log"
all_file_path = log_dir .. '/all'

unless fs.getInfo(log_dir)
    unless fs.createDirectory(log_dir)
        print"creation of logdir failed"

header = "Wesnoth for Love - global log file\n"
unless fs.getInfo(all_file_path)
    success, errormsg = fs.write(all_file_path, header)
    unless success
        print "couldn't create log file at #{all_file_path}: #{errormsg}"


apply_color = (str, severity) -> return log_color[severity] .. str .. color.reset


-- todo implement this stub
-- trace = (cfg) ->
--     return (txt) ->
--         msg(txt)

format_output = (severity, topic, txt) -> "(#{severity}) [#{topic}] #{txt}"

prepand_date = (str) ->
    date = os.date("*t", os.time!)
    with date
        date  = "[#{.hour}:#{.min}:#{.sec}]"
    return "#{date} #{str}"


arg = arg
logger = (file) ->
    argparse = require'cmd_line'

    cfg = argparse(arg)

    config = {}
    if debug = cfg.debug
        config[debug] = true

    file_path = log_dir .. '/' .. file

    msg = (txt, severity) ->
        output = prepand_date(txt)

        -- log to own file
        success, errormsg = fs.append(
            file_path, "#{output}\n")
        unless success
            print(apply_color("Could not append to Logfile: #{errormsg}", "warn"))

        -- log to global file
        success, errormsg = fs.append(
            all_file_path, "#{output}\n")
        unless success
            print(apply_color("Could not append to Logfile: #{errormsg}", "warn"))

        -- log to stdout
        print(apply_color(output, severity))


    header = "Wesnoth for Love - #{file} log file\n"
    fs.remove(file_path)

    success, errormsg = fs.write(file_path, header)
    unless success
        print "couldn't create log file at #{file_path}: #{errormsg}"


    domain_severity_log = (topic, severity) ->
        return (txt) ->
            -- todo we need to take car about:
            -- global arg is only defined in main thread
            -- isthread = arg == nil
            -- if isthread

            if severity == "debug"
                unless config[topic]
                    if config.logger
                        output = format_output("debug", "logger", "domain [#{topic}] disabled")
                        msg(output, "debug")
                    return
            output = format_output(severity, topic, txt)
            msg(output, severity)


    log = (topic) -> {
        error: domain_severity_log(topic, "error")
        debug: domain_severity_log(topic, "debug")
        warn:  domain_severity_log(topic, "warn")
        info:  domain_severity_log(topic, "info")
        -- trace: trace(topic)
        -- :set_config
    }

    return log


return logger

