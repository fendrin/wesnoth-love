love = love

love.threaderror = (thread, errorstr) ->
    -- thread:getError() will return the same error string now.
    print("Thread error!\n"..errorstr)

thread = love.thread.newThread("server/main.lua")
thread\start!

