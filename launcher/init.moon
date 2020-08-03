love = love
run = require"shared.run_moon"
load = require'launcher.load'

love.load = (arg) -> run(-> load(arg))
