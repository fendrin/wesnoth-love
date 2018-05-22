
color = require"log.ansicolors"
log_color =
    error: color.red
    warn:  color.yellow
    info:  color.green
    debug: color.blue


log_file  = "log.txt"

love = love
fs   = love.filesystem

header = "Wesnoth/Irdya log file\n"

success, errormsg = fs.write(log_file, header)

unless success
    print "couldn't write log file: #{errormsg}"


msg = (txt) ->
    date = os.date("*t", os.time!)
    local datum
    with date
        datum  = "[#{.hour}:#{.min}:#{.sec}]"
    output = "#{datum} #{txt}"
    success, errormsg = love.filesystem.append(
        log_file, "#{output}\n")
    print(output)

topics =
    filesystem: false
    AStarSearch: true


log = (topic, severity) ->
    return (txt) ->
        if severity == "debug"
            unless topics[topic]
                return
        output = "(#{severity}) [#{topic}] #{txt}"
        msg(log_color[severity] .. output .. color.reset)


trace = (cfg) ->
    return (txt) ->
        msg(txt)


logging = (topic) -> {
    error: log(topic, "error")
    debug: log(topic, "debug")
    warn:  log(topic, "warn")
    info:  log(topic, "info")
    trace: trace(topic)
}

return logging
