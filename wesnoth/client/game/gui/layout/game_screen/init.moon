----
-- Copyright (C) 2018 by Fabian Mueller <fendrin@gmx.de>
-- SPDX-License-Identifier: GPL-2.0+



infoItem = (id, text, icon, width) -> {
    id: id
    type: 'label'
    width: width, height: 24
    icon: 'assets/' .. icon
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
    icon: "assets/damage/blank.png"
    width: 56
    height: 27
    {
        margin: 0
        padding: 0
        id: "#{unit}UnitAttack#{i}#{value}"
        align: "right, middle"
        color: {0.7,0.7,0.7}
        width: 51
        height: 27
        size: 12
    }
}

weapon = (unit, i) -> {
    flow: 'x'
    margin:  0
    padding: 0
    {
        width:  60
        height: 60
        icon: "assets/data/core/images/attacks/blank-attack.png"
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
            slices: "assets/data/core/images/attacks/blank-attack.png"
            width: 56
            height: 27
            color: {0.7,0.7,0.7}
            align: "center, middle"
            id: "#{unit}UnitAttack#{i}Chance"
        }
        {
            width: 56
            height: 27
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
        height: 20
        width:  iconWidth

        align: "center, middle"
        size: 14
        color: {1,1,1}
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
    {
        width:  45
        height: 45
        id: id .. "Unit#{topic}"
        align: "center, middle"
    }
    {
        height: "auto"
        {
            id: id .. "Unit#{topic}Trait1"
            width: 18
            height: 18
        }
        {
            width: 18
            height: 18
            id: id .. "Unit#{topic}Trait2"
        }
    }
    {
        height: "auto"
        {
            id: id .. "Unit#{topic}Trait3"
            width: 18
            height: 18
        }
        {
            width: 18
            height: 18
            id: id .. "Unit#{topic}Trait4"
        }
    }
}


terrainInfo = (sort) -> {
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
        terrainInfo"swamp_water"
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
        terrainInfo"frozen"
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

    padding: 0
    margin:0
    {
        id: "#{id}UnitName"
        type: "label"
        size: 14
        height: 24
        color: {0.7,0.7,0.7}
    }
    {
        id: "#{id}UnitType"
        type: "label"
        size: 14
        height: 24
        color: {1,1,1}
    }

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
            value_bar("#{id}UnitLocation", nil, 78, 78)
            value_bar("#{id}UnitStatus",   nil, 78, 78)
            value_bar("#{id}UnitVision",
                "assets/data/core/images/themes/visionpoints.png",
                78, 60)
        }
    }
    resistances(id)
    moveType!
    weapon(id, 1)
    weapon(id, 2)
    weapon(id, 3)
}



itemInfo = (icon, width) -> {
    flow: 'x'
    width: "auto"
    {
        width: 30
        icon: icon
        align: "center, middle"
    }
    {
        type: "label"
        text: 26
        color: {0,1,0}
        :width
        align: "right"
    }
    {
        :width
        type: "label"
        text: 44
        color: {0,0,1}
        align: "right"
    }
    {
        :width
        type: "label"
        text: 65
        color: {1,0,0}
        align: "right"
    }
    {
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
    padding: 5
    height: "auto"
    width: "auto"
    size: 14
    slices: "assets/data/core/images/attacks/blank-attack.png"
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
    slices: "assets/data/core/images/attacks/blank-attack.png"
    padding: 0
    margin: 0
    {
        padding: 0
        margin: 0
        type: 'label'
        width:  135
        height:  49
        align: "middle center"
        slices: "assets/data/core/images/attacks/blank-attack.png"
        icon: "assets/data/core/images/misc/time-schedules/default/schedule-dusk.png"
        id: 'todImg'
    }
    {
        padding: 2
        margin: 0
        type: "label"
        width: 25
        height: 49
        align: "top"
        text: "12\n /\n16"
    }
}

turns = {
    width: "auto"
    height: "auto"
    flow: "x"
    slices: "assets/data/core/images/attacks/blank-attack.png"
    padding: 0
    margin: 0
    {
        id: 'flag'
        padding: 0
        margin: 0
        type: 'label'
        width:  49
        height:  49
        align: "middle center"
        slices: "assets/data/core/images/attacks/blank-attack.png"
        icon: "assets/data/core/images/flags/wood-elvish-flag-icon2x.png"
    }
    {
        padding: 2
        margin: 0
        type: "label"
        width: 35
        height: 49
        align: "top"
        text: "128\n  /\n999"
    }
}

status = {
    background: {0,0,0}
    type: 'status'
    height: 20
    size: 12
    padding: 0
    margin: 0
}

statusPanel = {
    flow: 'y'
    height: "auto"
    {
        width: 'auto'
        flow: 'x'
        background: { 0.05, 0.05, 0.05 }
        unitBox("primary")
        { width: 7 }
        unitBox("secondary")
        { width: 'auto'}
    }
    status
}

miniMap = {
    flow: 'y'
    slices: "assets/data/core/images/attacks/blank-attack2.png"
    padding: 6
    background: {0.05,0.05,0.05}
    { id: "miniMap", align: 'middle center',    background: {0,0,0} }
    {
        flow: 'x'
        height: 'auto'
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
}

menuButton = {
    icon: "assets/images/icons/icon-game.png"
    align: "center, middle"
    width: 64
    height: 64
    id: "menuButton"
}

bottom = {
    height: "auto"
        {
        flow: 'x'
        {
            flow: 'y'
            {
                height: 7
            }
            {
                flow: 'x'
                timeOfDay
                turns
                menuButton
            }
            {
                height: 5
            }
        }
    }
}

sideBar = {
    id: "sideBar"
    width: "auto"
    minwidth: 358
    padding: 4
    background: {0.05,0.05,0.05}

    bottom
    sideBox
    miniMap
    statusPanel
}

{
    id: 'screen'
    flow: 'x'
    {
        id: 'gameMap'
        minwidth: 700
    }
    {
        type: 'sash'
    }
    sideBar
}

