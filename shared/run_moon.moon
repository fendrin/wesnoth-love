errors = require"moonscript.errors"
error_handler = (err) ->
    trace = debug.traceback!
    return (errors.rewrite_traceback(trace, err))

----
-- Runs the given function error traceback rewritten with additional moonscript file line numbers
-- @param fun function to run
-- @return the return values of @fun
run = (fun, ...) ->
    res, val = xpcall(fun, error_handler, ...)

    if res
        return val
    else
        error(val)

return run
