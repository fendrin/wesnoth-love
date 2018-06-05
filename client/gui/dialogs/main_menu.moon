love = love
log = (require"log")"mainMenu"


main_menu = (screen) ->

    log.info"main_menu dialog called"
    menu_dlg = (require"client.gui.dialog")("main_menu")

    with menu_dlg
        -- .tutorial\onPress((event) ->
        --     menu_dlg\hide!
        --     server = love.thread.getChannel( 'server' )
        --     mapRequest = {
        --         request_name: "mapRequest"
        --         id: "tutorial"
        --     }
        --     server\push(mapRequest)
        --     screen("load")
        -- )
        .demo\onPress((event) ->
            menu_dlg\hide!
            server = love.thread.getChannel( 'server' )
            mapRequest = {
                request_name: "startCampaign"
                id: "An_Orcish_Incursion"
            }
            server\push(mapRequest)
            screen("load")
        )
        -- .preferences\onPress((event) ->
        --     screen("prefs", "title")
        -- )

        menu_dlg.quit\onPress((event) -> love.event.quit! )

    return menu_dlg

return main_menu
