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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    state.MagicBurst = M(false, 'Magic Burst') 
     
    gear.default.obi_waist = "Sekhmet Corset"
    
	send_command('bind @` gs c activate MagicBurst')
	
    select_default_macro_book()
end

function user_unload()
   
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {
    main="Vitiation Sword",
    sub="Thuellaic Shield +1",
    ammo="Ombre Tathlum",
    head="Teal Chapeau",
    body="Teal Saio",
    hands="Teal Cuffs",
    legs="Teal Slops",
    feet="Teal Pigaches",
    neck="Dls. Torque +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+15','Mag. Acc+1 /Mag. Dmg.+1','"Fast Cast"+6',}},
}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {})

    sets.precast.WS['Sanguine Blade'] = {}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
    main="Vitiation Sword",
    sub="Sors Shield",
    ammo="Ombre Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Conduit Shoes +1",
    neck="Dls. Torque +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+15','Mag. Acc+1 /Mag. Dmg.+1','"Fast Cast"+6',}},
}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {}

    sets.midcast['Enhancing Magic'] = {
    main="Vitiation Sword",
    sub="Thuellaic Ecu +1",
    ammo="Ombre Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Duelist's Gloves",
    legs="Ea Slops",
    feet="Conduit Shoes +1",
    neck="Dls. Torque +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+15','Mag. Acc+1 /Mag. Dmg.+1','"Fast Cast"+6',}},
}

    sets.midcast.Refresh = {}

    sets.midcast.Stoneskin = {}
    
    sets.midcast['Enfeebling Magic'] = {
    main="Vitiation Sword",
    sub="Thuellaic Ecu +1",
    ammo="Ombre Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Duelist's Gloves",
    legs="Ea Slops",
    feet="Conduit Shoes +1",
    neck="Dls. Torque +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+15','Mag. Acc+1 /Mag. Dmg.+1','"Fast Cast"+6',}},
}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {})
    
    sets.midcast['Elemental Magic'] = {
    main="Vitiation Sword",
    sub="Thuellaic Ecu +1",
    ammo="Ombre Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Duelist's Gloves",
    legs="Ea Slops",
    feet="Conduit Shoes +1",
    neck="Dls. Torque +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+15','Mag. Acc+1 /Mag. Dmg.+1','"Fast Cast"+6',}},

}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Dark Magic'] = {}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {}
        
    sets.buff.ComposureOther = {}

    sets.buff.Saboteur = {}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
    main="Iridal Staff",
    ammo="Ombre Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Conduit Shoes +1",
    neck="Dls. Torque +1",
    waist="Gerdr Belt",
    left_ear="Mache Earring +1",
    right_ear="Mache Earring +1",
    left_ring="Shiva Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+15','Mag. Acc+1 /Mag. Dmg.+1','"Fast Cast"+6',}},
    }

    -- Idle sets
    sets.idle = {
    main="Vitiation Sword",
    sub="Thuellaic Ecu +1",
    ammo="Ombre Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Conduit Shoes +1",
    neck="Dls. Torque +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Sucellos's Cape", augments={'MND+15','Mag. Acc+1 /Mag. Dmg.+1','"Fast Cast"+6',}},
 }
    sets.idle.Town = {}
    
    sets.idle.Weak = {}

    sets.idle.PDT = {}

    sets.idle.MDT = {}
    
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {}

    sets.latent_refresh = {}


     sets.precast.Magic_Burst = set_combine(sets.precast.FC, {})
     
    sets.midcast.Magic_Burst = {}    	 
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
    main="Vitiation Sword",
    sub="Thuellaic Ecu +1",
    ammo="Ombre Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Conduit Shoes +1",
    neck="Dls. Torque +1",
    waist="Gerdr Belt",
    left_ear="Mache Earring +1",
    right_ear="Mache Earring +1",
    left_ring="Chirich Ring",
    right_ring="Chirich Ring",
    back="Seshaw Cape",
}

    sets.engaged.Defense = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4)
    end
end

