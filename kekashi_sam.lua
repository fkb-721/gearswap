-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {}
    sets.precast.JA['Warding Circle'] = {}
    sets.precast.JA['Blade Bash'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    main="Sakonji-no-Tachi",
    sub="Alber Strap",
    ammo="Aurgelmir Orb",
    head="Ken. Jinpachi",
    body="Ken. Samue",
    hands="Ken. Tekko",
    legs="Ken. Hakama",
    feet="Ken. Sune-Ate",
    neck="Moonbeam Nodowa",
    waist="Flame Belt",
    left_ear="Mache Earring +1",
    right_ear="Centaurus Earring",
    left_ring="Ifrit Ring +1",
    right_ring="Ifrit Ring",
    back="Atheling Mantle",}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {})


    -- Midcast Sets
    sets.midcast.FastRecast = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {}
    
    sets.idle.Field = {}

    sets.idle.Weak = {}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.Reraise = {}

    sets.defense.MDT = {}

    sets.Kiting = {}

    sets.Reraise = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
    main="Sakonji-no-Tachi",
    sub="Alber Strap",
    ammo="Aurgelmir Orb",
    head="Ken. Jinpachi",
    body="Ken. Samue",
    hands="Ken. Tekko",
    legs="Ken. Hakama",
    feet="Ken. Sune-Ate",
    neck="Moonbeam Nodowa",
    waist="Sweordfaetels",
    left_ear="Mache Earring +1",
    right_ear="Steelflash Earring",
    left_ring="Chirich Ring",
    right_ring="Chirich Ring",
    back="Atheling Mantle",
}
    sets.engaged.Acc = {}
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}
    sets.engaged.Reraise = {}
    sets.engaged.Acc.Reraise = {}
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = {}
    sets.engaged.Adoulin.Acc = {}
    sets.engaged.Adoulin.PDT = {}
    sets.engaged.Adoulin.Acc.PDT = {}
    sets.engaged.Adoulin.Reraise = {}
    sets.engaged.Adoulin.Acc.Reraise = {}


    sets.buff.Sekkanoki = {}
    sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 11)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 11)
    else
        set_macro_page(1, 11)
    end
end

