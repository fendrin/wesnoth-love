----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+


love = love
log  = (require"log")"server"

log.info"Start..."

client = love.thread.getChannel( 'client' )
server = love.thread.getChannel( 'server' )


log.info'start gameLoop'
running = true

wrapInArray = (cfg) ->
    if #cfg == 0
        return {cfg}
    else return cfg

local wesnoth
unitTransfer = ->
    for unit in *wesnoth.get_units({})

        -- @todo find a solution for the future turn reach feature
        path_turns = 0

        reach = wesnoth.find_reach(unit, {
            -- @todo translate the parameters
            -- pathfind.Paths(un, false, true,
            --     viewing_team(), path_turns_)
            additional_turns: path_turns
        })
        reach_map = {}
        for step in *reach
            loc_x = step[1].x
            loc_y = step[1].y
            unless reach_map[loc_x]
                reach_map[loc_x] = {}
            reach_map[loc_x][loc_y] = step

        client_info = {
            command_name: "Unit"

            reach: reach_map
            side: unit.side
            experience: unit.experience
            max_experience: unit.max_experience
            name: unit.name
            image: unit.image
            can_recruit: unit.can_recruit or unit.canrecruit
            x: unit.x
            y: unit.y
            id: unit.id
            type: unit.type
            hitpoints: unit.hitpoints
            max_hitpoints: unit.max_hitpoints
            moves: unit.moves
            max_moves: unit.max_moves
            movement: {
                ["Gs^Fds"]: 2
            }
            attack: wrapInArray(unit.attack)
            alignment: unit.alignment
            race: unit.race
        }
        client\push(client_info)


new = true
local controller
while running

    if new
        new = false

        controller = (require"wesnoth").controller
        wesnoth    = (require"wesnoth").wesnoth

        controller.read_data_tree!
        assert(wesnoth.game_config)
        game_config = wesnoth.game_config
        game_config.command_name = "gameConfig"
        client\push(wesnoth.game_config)

    value = server\demand!

    switch value.request_name
        when "startCampaign"
            controller.load_campaign(value.id)
            -- for side in *wesnoth.sides
            --     side.command_name = 'Side'
            --     client\push(side)
            board = controller.gameBoard!
            log.info"push map to the client channel"
            board.map.command_name = "map"
            client\push(board.map)
            unitTransfer!
            controller.start_scenario!
        else
            assert(false, "unhandled request: #{value.request_name}")
