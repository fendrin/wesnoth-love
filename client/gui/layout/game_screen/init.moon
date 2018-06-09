get = require"filesystem"

infoItem = (id, text, icon, width) -> {
    id: id
    type: 'label'
    width: width, height: 24
    icon: get.assets(icon)
    {
        align: 'center, middle'
        text: text
        color: {0.7,0.7,0.7}
    }
}

infoPair = (first, second) -> {
    flow: 'x'
    height: "auto"
    first, {width: 2}, second
}

weapon_attribute = (unit, i, icon, value) -> {
    id: "#{unit}UnitAttack#{i}#{icon}"
    type: "label"
    margin:  0
    padding: 0
    icon: get.assets"damage/blank.png"
    width: 56
    height: 27
    {
        margin: 0
        padding: 0
        id: "#{unit}UnitAttack#{i}#{value}"
        -- align: "center, right"
        align: "right, middle"
        color: {0.7,0.7,0.7}
        -- type: "label"
        width: 51
        height: 27
        size: 12
    }
}

weapon = (unit, i) -> {
    flow: 'x'
    margin:  0
    padding: 0
    -- slices: get.assets"data/core/images/attacks/blank-attack.png"
    {
        width:  60
        height: 60
        icon: get.assets"data/core/images/attacks/blank-attack.png"
        align: "center, middle"
        margin:  0
        padding: 0
        id: "#{unit}UnitAttack#{i}"
    }
    {
        margin:  0
        padding: 0
        height: "auto"
        width: "auto"
        align: "center, middle"

        {
            height: 3
        }
        weapon_attribute(unit, i, "Range", "Strikes")
        weapon_attribute(unit, i, "Type", "Damage")
    }
    {
        margin: 0
        padding: 0
        height: "auto"
        width: "auto"
        {
            height: 3
        }
        {
            slices: get.assets"data/core/images/attacks/blank-attack.png"
            width: 56
            height: 27
            color: {0.7,0.7,0.7}
            align: "center, middle"
            id: "#{unit}UnitAttack#{i}Chance"
        }
        {
             -- slices: get.assets"data/core/images/attacks/blank-attack.png"
            width: 56
            height: 27
            -- icon: "assets/marksman.png"
            align: "center, middle"
        }
    }
}


value_bar = (id, icon, width=86, iconWidth=65) -> {
    height: 20
    :width
    slices: "assets/damage/blank.png"
    flow: 'x'
    {
        icon: icon
        align: "center, middle"
    }
    {
        id: id
        -- margin: 1
        -- padding: 1
        height: 20
        width:  iconWidth

        align: "center, middle"
        -- color
        -- type: "progress"
        -- value: 0.7
        -- {
        --     id: id .. "UnitHP"
        --     text: 38
        size: 14
        --     height: 20
        color: {1,1,1}
        -- }
    }
}

row1 = -> {
    height: 25
    flow: 'x'
    {
        width: 2
    }
    {
        icon: "assets/damage/blade.png"
        width: 56
    }
    {
        icon: "assets/damage/pierce.png"
        width: 56
    }
    {
        icon: "assets/damage/impact.png"
        width: 56
    }
}

row2 = -> {
    height: 25
    flow: 'x'
    {
        width: 2
    }
    {
        icon: "assets/damage/arcane.png"
        width: 56
    }
    {
        icon: "assets/damage/fire.png"
        width: 56
    }
    {
        icon: "assets/damage/cold.png"
        width: 56
    }
}


resistances = (id) -> {
    height: "auto"
    row1!
    row2!
}


attributeBox = (id, topic) -> {
    flow: 'x'
    slices: "assets/data/core/images/attacks/blank-attack.png"
    height: "auto"
    width:  "auto"
    -- margin: 3
    -- padding: 5
    {
        width:  45
        height: 45
        -- height: 45
        id: id .. "Unit#{topic}"
        align: "center, middle"
    }
    {
        height: "auto"
        {
            id: id .. "Unit#{topic}Trait1"
            -- icon: "assets/strong.png"
            width: 18
            height: 18
        }
        {
            width: 18
            height: 18
            id: id .. "Unit#{topic}Trait2"
            -- icon: "assets/quick.png"
        }
    }
    {
        height: "auto"
        {
            id: id .. "Unit#{topic}Trait3"
            -- icon: "assets/strong.png"
            width: 18
            height: 18
        }
        {
            width: 18
            height: 18
            id: id .. "Unit#{topic}Trait4"
            -- icon: "assets/quick.png"
        }
    }
}


terrainInfo = (sort) -> {
    -- outline: {1,1,1}
    width: "auto"
    height: "auto"
    margin: 0
    padding: 0
    {
        height: 18
        width: 20
        icon: "assets/images/icons/terrain/terrain_type_#{sort}.png"
        align: "center middle"
    }
    {
        height: 10
        width: 20
        -- text: 2
        color: {1,1,1}
        align: "center middle"
        size: 9
    }
    {
        size: 9
        align: "center middle"
        color: {1,1,1}
        height: 10
        width: 20
        -- text: 60
    }
}

moveType = -> {
    height: "auto"
    width: "auto"
    slices: "assets/data/core/images/attacks/blank-attack.png"
    padding: 5
    margin: 0
    {
        flow: 'x'

        terrainInfo"flat"
        terrainInfo"hills"
        terrainInfo"mountains"
        terrainInfo"forest"
        terrainInfo("swamp_water")
        terrainInfo"shallow_water"
        terrainInfo"deep_water"
        terrainInfo"reef"
    }
    {
        flow: 'x'
        terrainInfo"fungus"
        terrainInfo"cave"
        terrainInfo"castle"
        terrainInfo"village"
        terrainInfo("frozen")
        terrainInfo"sand"
        terrainInfo"unwalkable"
        terrainInfo"rails"
    }
}

unitBox = (id) -> {
    id: "#{id}Unit"
    flow: 'y'
    height: 'auto'
    background: {0.05,0.05,0.05}
    -- {
        -- height: "auto"
        -- flow: 'x'
    padding: 0
    margin:0
    {
        id: "#{id}UnitName"
        type: "label"
        size: 14
        height: 24
        color: {0.7,0.7,0.7}
    }
    -- {
    --     id: "#{id}UnitType"
    --     type: "label"
    --     size: 14
    --     height: 24
    --     color: {1,1,1}
    --     -- text: "Elvish Rider"
    -- }
    -- }
    {
        height: "auto"
        flow: 'x'
        {
            id: "#{id}UnitImage"
            slices: "assets/data/core/images/attacks/blank-attack.png"
            height: 90
            width:  90
            align: "center, middle"
        }
        {
            margin: 0
            padding: 0
            -- {
            --     id: "#{id}UnitLocation"
            --     size: 15
            --     height: 22
            --     type: "label"
            --     color: {0.7,0.7,0.7}
            -- }
            -- infoItem("location", "14/39",
                -- "images/icons/action/editor-brush-1_30.png")
            -- {
            --     padding: 0
            --     margin: 0
            --      -- slices: "assets/data/core/images/attacks/blank-attack.png"
            --     width: 42
            --     height: 42
            --     align: "center, middle"
            --     id: id .. "UnitAlignment"
            -- }
            attributeBox(id, "Race")
            attributeBox(id, "Alignment")
        }
    }
    {
        flow: 'x'
        width: "auto"
        {
            width: 2
        }
        {
            width: "auto"
            value_bar("#{id}UnitHP",
                "assets/data/core/images/themes/hitpoints.png")
            value_bar("#{id}UnitXP",
                "assets/data/core/images/themes/experiencepoints.png")
            value_bar("#{id}UnitMP",
                "assets/data/core/images/themes/movepoints.png")
        }
        {
            width: 4
        }
        {
            -- value_bar("#{id}UnitLocation", "assets/images/icons/action/editor-brush-1_25-active.png", 78, 62)
            value_bar("#{id}UnitLocation", nil, 78, 78)
            value_bar("#{id}UnitStatus",   nil, 78, 78)
            value_bar("#{id}UnitVision",
                "assets/data/core/images/themes/visionpoints.png",
                78, 60)
            -- id: "#{id}UnitLocation"
            -- size: 15
            -- height: 22
            -- type: "label"
            -- color: {0.7,0.7,0.7}
        }
    }
    resistances(id)
    moveType!
    -- value_bar!
    -- value_bar!

    weapon(id, 1)
    weapon(id, 2)
    weapon(id, 3)
}



itemInfo = (icon, width) -> {
    flow: 'x'
     -- slices: "assets/blank.png"
    width: "auto"
    {
        width: 30
        -- width: "auto"
        icon: icon
        align: "center, middle"
    }
    {
        --  -- slices: "assets/blank2.png"
        --  -- slices: "assets/blank.png"
        type: "label"
        text: 26
        color: {0,1,0}
        :width
        align: "right"
    }
    {
        --  -- slices: "assets/blank2.png"
        --  -- slices: "assets/blank.png"
        :width
        type: "label"
        text: 44
        color: {0,0,1}
        align: "right"
    }
    {
        :width
        --  -- slices: "assets/blank.png"
        type: "label"
        text: 65
        color: {1,0,0}
        align: "right"
    }
    {
        --  -- slices: "assets/blank.png"
        -- margin: 0
        -- padding: 0
        -- outline: {0.7,0.7,0.7 }
        type: "label"
        text: 56
        color: {1,1,1}
        align: "right"
        :width
    }
}

villageInfo = ->
    itemInfo("assets/data/core/images/themes/villages.png", 25)

unitsInfo = ->
    itemInfo("assets/data/core/images/themes/units.png", 25)

incomeInfo = ->
    itemInfo("assets/data/core/images/themes/income.png", 45)

upkeepInfo = ->
    itemInfo("assets/data/core/images/themes/upkeep.png", 45)

goldInfo = ->
    itemInfo("assets/data/core/images/themes/gold.png", 45)

sideBox = {
    background: {0,0,0}
    padding: 5
    height: "auto"
    width: "auto"
    size: 14
     -- slices: "assets/data/core/images/attacks/blank-attack.png"
    infoPair(villageInfo!, incomeInfo!)
    infoPair(unitsInfo!, upkeepInfo!)
    infoPair(
        infoItem("time", "10:19",
            "data/core/images/themes/sand-clock.png", 130),
        goldInfo!
    )
}

timeOfDay = {
    width: "auto"
    height: "auto"
    flow: "x"
     -- slices: "assets/data/core/images/attacks/blank-attack.png"
    padding: 0
    margin: 0
    {
        padding: 0
        margin: 0
        type: 'label'
        width:  135
        height:  49
        align: "middle center"
         -- slices: "assets/data/core/images/attacks/blank-attack.png"
        icon: get.assets"data/core/images/misc/time-schedules/default/schedule-dusk.png"
    }
    {
        padding: 0
        margin: 0
        type: "label"
        width: 135
        height: 49
        align: "center middle"
        text: "12/16"
    }
}

statusPanel = {
    flow: 'y'
    height: "auto"

    sideBox
    {
        flow: 'x'
        background: {0.05,0.05,0.05}
        unitBox("primary")
        { width: 5}
        unitBox("secondary")
    }
}

miniMap = {
    flow: 'x'
    {
        width: 25
        {
            height: 25, width: 25
            icon: "assets/images/icons/action/minimap-unit-coding_25.png"
        }
        {
            height: 25, width: 25
            icon: "assets/images/icons/action/minimap-draw-terrain_25.png"
        }
        {}
        {
            height: 25, width: 25
            icon: "assets/images/icons/action/minimap-terrain-coding_25.png"
        }
        {
            height: 25, width: 25
            icon: "assets/images/icons/action/editor-draw-coordinates_25-active.png"
        }
        background: {0,0,0}
    }
    { id: "miniMap" }
}

bottom = {
    height: "auto"
    background: {0,0,0}
    {
        background: {0,0,0}
        type: 'status'
        height: 20
        size: 12
        padding: 0
        margin: 0
    }
    {
        flow: 'x'
        {
            icon: "assets/data/core/images/flags/wood-elvish-flag-icon2x.png"
            align: "center, middle"
            width: 48
             -- slices: "assets/data/core/images/attacks/blank-attack.png"
        }
        {
            flow: 'y'
            margin: 0
            padding: 0
            {
                 -- slices: "assets/data/core/images/attacks/blank-attack.png"
                text: "999"
                align: "center, middle"
                height: 26
            }
            {
                height: 26
                 -- slices: "assets/data/core/images/attacks/blank-attack.png"
                align: "center, middle"
                text: "999"
            }
            -- width: 50
            color: {1,1,1}
        }
        timeOfDay
    }
}

sideBar = {
    id: "sideBar"
    -- minwidth: 350
    -- width: 350
    width: "auto"
    miniMap
    -- {
    --     type: 'sash'
    --     height: 5
    --      -- slicesV: get.assets"images/dialogs/opaque-border-bottom.png"
    -- }
    statusPanel
    bottom
}

{
    id: 'screen'
    flow: 'x'
    {
        id: 'gameMap'
        minwidth: 700
    }
    {
        -- type: 'sash'
        width: 8
        slices: "assets/images/dialogs/thin_translucent-border-left.png"
    }
    sideBar
}

-- thing = {
--     id: 'leftSideBox', minwidth: 200, width: 200, scroll: true,
--     type: 'panel',
--     context: {
--         { text: 'Use sans-serif font', id: 'sans' },

--         { text: 'Use monospace font', id: 'mono' }
--     },










--     {
--         style: 'listThing', align: 'middle center',
--         text: 'Try the scroll wheel on this area.',
--     },
--     {
--         style: 'listThing', align: 'middle center',
--         text: 'This text is centered, and in the middle vertically.'
--     },
--     {
--         style: 'listThing', align: 'middle left',
--         text: 'This text is aligned left, and in the middle vertically.'
--     },
--     {
--         style: 'listThing', align: 'middle right',
--         text: 'This text is aligned right, and in the middle vertically.'
--     },
--     {
--         style: 'listThing', align: 'top center',
--         text: 'This text is centered, and at the top vertically.'
--     },
--     {
--         style: 'listThing', align: 'bottom center',
--         text: 'This text is centered, and at the bottom vertically.'
--     },
-- }

-- love = love
-- li = love.image
-- img = li.newImageData(get.assets"images/icons/icons-resistances.png")

-- dx = 0
-- dy = 0
-- sx = 0
-- sy = 0
-- sw = 36
-- sh = 26
-- top_left = li.newImageData(sw, sh)
-- top_left\paste( img, dx, dy, sx, sy, sw, sh )
-- bottom_left = li.newImageData(sw, sh)
-- bottom_left\paste( img, 0, 0, 36, 0, 36, 26 )

-- locationInfo = {
--     height: "auto"
--     infoPair(infoItem("location", "14/39",
--             "images/icons/action/editor-brush-1_30.png"),
--         infoItem("terrainIcon", "Mountains",
--             "images/icons/terrain/terrain_type_mountains_30.png")
--     )
-- }
