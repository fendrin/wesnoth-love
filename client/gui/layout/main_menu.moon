{
    type: "window"
    flow: 'x'
    {},{},{},{},{}
    {
        flow: 'y'
        {}
        {
            id: "mainMenu"
            slices: "assets/themes/wesnoth-highres/submenu.png"
            background: {0.25,0.25,0.25,0.65}
            width: "auto"
            height: "auto"
            padding: 18
            margin: -3
            { style: 'menuButton', id: 'tutorial', text: 'Tutorial' }
            -- { style: 'menuButton', id: 'campaigns', text: 'Campaigns' }
            -- { style: 'menuButton', id: 'multiplayer', text: 'Multiplayer' }
            -- { style: 'menuButton', id: 'load', text: 'Load' }
            -- { style: 'menuButton', id: 'add_ons', text: 'Add-ons' }
            -- { style: 'menuButton', id: 'mapEditor', text: 'Map Editor' }
            -- { style: 'menuButton', id: 'language', text: 'Language' }
            { style: 'menuButton', id: 'preferences', text: 'Preferences' }
            -- { style: 'menuButton', id: 'credits', text: 'Credits' }
            { style: 'menuButton', id: 'quit', text: 'Exit' }
        }
        {}
        {}
    }
}
