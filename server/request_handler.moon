----
-- Copyright (C) 2020 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+

log        = (require"log")"server"
controller = (require"wesnoth").controller
wesnoth    = (require"wesnoth").wesnoth

wrapInArray = (cfg) ->
    if #cfg == 0
        return {cfg}
    else return cfg

transfer_units = ->
    client_info = {
        command_name: "Units"
        units: {}
    }
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

        unit_info = {

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
        table.insert(client_info.units, unit_info)
    return client_info


request_handler = (request) ->

    switch request.request_name
        when "Move"
            log.info("Move request not implemented yet")
        -- when "startCampaign"
        --     controller.load_campaign(request.id)
        --     -- for side in *wesnoth.sides
        --     --     side.command_name = 'Side'
        --     --     client\push(side)
        --     board = controller.gameBoard!
        --     log.debug"push map to the client channel"
        --     board.map.command_name = "map"
        --     setupReady = { command_name: "setupReady"}
        --     return {board.map, transfer_units!, setupReady}
        when "clientReady"
            -- controller.load_campaign(request.id)
            controller.load_campaign("An_Orcish_Incursion")
            -- for side in *wesnoth.sides
            --     side.command_name = 'Side'
            --     client\push(side)
            board = controller.gameBoard!
            log.debug"push map to the client channel"
            board.map.command_name = "map"
            setupReady = { command_name: "setupReady"}
            return {board.map, transfer_units!, setupReady}
            -- error'here'
            -- controller.start_scenario!
        when "startScenario"
            -- error"start_scenario"
            controller.start_scenario!
            return
        else
            assert(false, "unhandled request: #{request.request_name}")


return request_handler
