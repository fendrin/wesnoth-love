update_unit = (dlg, id, unit) ->

    return unless dlg["#{id}Unit"]

    unit_image =  unit and "assets/data/core/images/#{unit.image}" or
        nil
    dlg["#{id}UnitImage"].icon = unit_image
    unit_type = unit and unit.type or ""
    dlg["#{id}UnitImage"].status = unit_type
    -- dlg["#{id}UnitType"].text = unit_type
    unit_name = unit and unit.name or ""
    dlg["#{id}UnitName"].text  = unit_name
    alignment_icon = unit and "assets/images/icons/alignments/alignment_#{unit.alignment}_30.png" or nil
    dlg["#{id}UnitAlignment"].icon = alignment_icon
    race_icon = unit and
        "assets/images/icons/unit-groups/race_#{unit.race}_30.png" or nil
    dlg["#{id}UnitRace"].icon = race_icon
    unit_location = unit and "#{unit.x},#{unit.y}" or ""
    dlg["#{id}UnitLocation"].text = unit_location
    unit_hp = unit and "#{unit.hitpoints}/#{unit.max_hitpoints}" or ""
    dlg["#{id}UnitHP"].text = unit_hp
    unit_xp = unit and "#{unit.experience}/#{unit.max_experience}" or ""
    dlg["#{id}UnitXP"].text = unit_xp
    unit_mp = unit and "#{unit.moves}/#{unit.max_moves}" or ""
    dlg["#{id}UnitMP"].text = unit_mp

    -- require"moon".p unit

    icon_path = "assets/data/core/images/"
    -- if icon = unit.attack.icon
        -- dlg["#{id}UnitAttack1"].icon = icon_path .. icon

    for i=1, 3
        attack = unit and unit.attack and unit.attack[i]

        attack_chance = attack and "60%" or ""
        dlg["#{id}UnitAttack#{i}Chance"].text = attack_chance

        attack_icon = attack and icon_path .. attack.icon or
            icon_path .. "attacks/blank-attack.png"
        dlg["#{id}UnitAttack#{i}"].icon = attack_icon
        attack_name = attack and attack.description or "Hans-Frans"
        dlg["#{id}UnitAttack#{i}"].status = attack_name
        attack_damage = if attack then attack.damage else ""
        dlg["#{id}UnitAttack#{i}Damage"].text  = attack_damage
        attack_number = if attack then attack.number else ""
        dlg["#{id}UnitAttack#{i}Strikes"].text = attack_number
        range_icon = attack and "assets/" .. attack.range .. ".png" or
            "assets/damage/blank.png"
        dlg["#{id}UnitAttack#{i}Range"].icon = range_icon
        type_icon = if attack then "assets/damage/" ..
            attack.type .. ".png"
        else
            "assets/damage/blank.png"
        dlg["#{id}UnitAttack#{i}Type"].icon = type_icon


return update_unit
