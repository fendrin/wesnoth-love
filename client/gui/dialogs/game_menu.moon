love = love
log = (require"log")"gameMenu"

main_menu = (screen) ->

    log.info"game_menu dialog called"

    menu_dlg = (require"client.gui.dialog")("game_menu")

    with menu_dlg
        .resume\onPress(     (event) -> screen"game")
        -- .preferences\onPress((event) -> screen("prefs", "menu"))
        -- .quit\onPress(       (event) -> screen"title")
        .exit\onPress(       (event) -> love.event.quit!)

    log.info"dialog show"
    return menu_dlg

return main_menu
