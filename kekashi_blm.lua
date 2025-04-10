-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	include('Mote-selfcommands.lua')
	include('Mote-Globals.lua')
	include('Mote-Utility.lua')
	include('Mote-Mappings.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'Town')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    gear.macc_hagondes = {}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {}

    sets.precast.JA.Manafont = {}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {main="Archmage's Staff",
    sub="Caecus Grip",
    ammo="Impatiens",
    head="Teal Chapeau +1",
    body="Teal Saio +1",
    hands="Teal Cuffs +1",
    legs="Teal Slops +1",
    feet="Teal Pigaches +1",
    neck="Src. Stole +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Weather. Ring",
    right_ring="Stikini Ring +1",
    back="Toro Cape",}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {body="Wicce Coat"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {main="Raetic Rod",
    sub="Faerie Shield",
    ammo="Aqua Sachet",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Src. Stole +1",
    waist="Penitent's Rope",
    left_ear="Star Earring",
    right_ear="Healing Earring",
    left_ring="Levia. Ring +1",
    right_ring="Levia. Ring",
    back="Oretan. Cape +1",}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast['Enfeebling Magic'] = {}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = { feet="Arch. Sabots +1",waist="Austerity Belt +1",}
    
    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})

    sets.midcast.Stun = {}

    sets.midcast.BardSong = {}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Archmage's Staff",
    sub="Caecus Grip",
    ammo="Snow Sachet",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Src. Stole +1",
    waist="Skrymir Cord",
    left_ear="Moldavite Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring",
    back="Toro Cape",}

    sets.midcast['Elemental Magic'].Resistant = {}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {}


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="boonwell staff",
    sub="Caecus Grip",
    ammo="Snow Sachet",
    head="Knit Cap +1",
    body="Pluviale",
    hands="Ea Cuffs",
    legs="Assiduity Pants",
    feet="Ea Pigaches",
    neck="Src. Stole +1",
    waist="Austerity Belt +1",
    left_ear="Moldavite Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring",
    back="Toro Cape",}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = { main="Archmage's Staff",
    sub="Caecus Grip",
    ammo="Impatiens",
    head="Ea Hat",
    body="Wicce Coat",
    hands="Ea Cuffs",
    legs="Assiduity Pants",
    feet="Ea Pigaches",
    neck="Src. Stole +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Warp Ring",
    right_ring="Dim. Ring (Holla)",
    back="Toro Cape",}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {
    main="Archmage's Staff",
    sub="Caecus Grip",
    ammo="Snow Sachet",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Src. Stole +1",
    waist="Skrymir Cord",
    left_ear="Moldavite Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring",
    back="Toro Cape",
}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {}
    
    -- Town gear.
    sets.idle.Town = { main="Archmage's Staff",
    sub="Caecus Grip",
    ammo="Impatiens",
    head="Ea Hat",
    body="Councilor's Garb",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Src. Stole +1",
    waist="Skrymir Cord",
    left_ear="Enchntr. Earring +1",
    right_ear="Friomisi Earring",
    left_ring="Warp Ring",
    right_ring="Dim. Ring (Holla)",
    back="Toro Cape",}
        
    -- Defense sets

    sets.defense.PDT = {main="Terra's Staff",
    sub="Caecus Grip",
    ammo="Impatiens",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Cloud Hairpin",
    waist="Penitent's Rope",
    left_ear="Phawaylla Earring",
    right_ear="Dodge Earring",
    left_ring="Gelatinous Ring",
    right_ring="Spiral Ring",
    back="Oretan. Cape +1",}

    sets.defense.MDT = {main="Terra's Staff",
    sub="Caecus Grip",
    ammo="Impatiens",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Cloud Hairpin",
    waist="Penitent's Rope",
    left_ear="Phawaylla Earring",
    right_ear="Dodge Earring",
    left_ring="Gelatinous Ring",
    right_ring="Spiral Ring",
    back="Oretan. Cape +1",}

    sets.Kiting = {}

    sets.latent_refresh = {}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {}

    sets.precast.magic_burst = set_combine(sets.precast.FC, {})
    
	sets.midcast.magic_burst = {}
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
    main="Archmage's Staff",
    sub="Caecus Grip",
    ammo="Snow Sachet",
    head="Ea Hat",
    body="Ea Houppelande",
    hands="Ea Cuffs",
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Src. Stole +1",
    waist="Skrymir Cord",
    left_ear="Moldavite Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring",
    back="Toro Cape",
}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page()
end
