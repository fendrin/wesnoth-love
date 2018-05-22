errors = require"moonscript.errors"
errorHandler = (err) ->
    trace = debug.traceback!
    return errors.rewrite_traceback(trace, err)

----
-- Try/Catch style exception handling
-- Lifted from:
-- https://github.com/leafo/moonscript/wiki/Exception-handling
-- @tab t
-- @func t.do The guarded code.
-- @func t.catch Called iff 'do' fails.
-- @func[opt] t.finally Called iff 'do' succeeds.
-- @usage
-- try
--     do: ->
--         <guarded code chunk>
--     catch: (err) ->
--         <error handling>
--     finally: ->
--         <executed in all cases if present>
--
try = (t) ->
    ok, value = xpcall(t.do, errorHandler)
    if ok
        t.finally! if t.finally
        return value
    else
        catch = () -> t.catch(value)
        handled, backup_value = xpcall(catch, errorHandler)
        t.finally! if t.finally
        if handled
            return backup_value
        else
            error(backup_value, 2)


return try
