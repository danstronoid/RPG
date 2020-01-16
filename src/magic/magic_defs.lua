--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Magic Defs --
    
    This is a table of all magic spells and their definitions.
    
    Each spell is in the format:
    ['spell name'] = {
        name = spell name (needs to be consistent with table key),
        action = name of action function to call when used,
        element = the elemental attribute of a spell,
        mp_cost = the mp needed to cast the spell,
        base_dmg = the base damage amount, can be a table {normal, critical},
        base_heal = the base amount of healing,
        mod = a table of any status modifications (for buff spells),
        duration = the duration of any status effects,
        target = {
            select = does it target the party or the enemies
            type = how many (one or all)
            revive = boolean for whether it can target dead characters
        },
        text = brief description,
    }
]]


MAGIC_DEFS = {
    ['Fire'] = {
        name = 'Fire',
        action = 'element_spell',
        element = 'fire',
        mp_cost = 4,
        base_dmg = {3, 5},
        target = {
            select = 'enemies',
            type = 'one'
        },
        text = 'Damage an enemy with fire.'
    },
    ['Ice'] = {
        name = 'Ice',
        action = 'element_spell',
        element = 'ice',
        mp_cost = 4,
        base_dmg = {3, 5},
        target = {
            select = 'enemies',
            type = 'one'
        },
        text = 'Damage an enemy with ice.'
    },
    ['Heal'] = {
        name = 'Heal',
        action = 'hp_restore_spell',
        mp_cost = 4,
        base_heal = 60,
        target = {
            select = 'party',
            type = 'one'
        },
        text = 'Restores a small amount of HP to a party member.'
    },
    ['Protect'] = {
        name = 'Protect',
        action = 'buff_spell',
        mp_cost = 4,
        mod = {
            mult = {['dfn'] = 1},
            temp = true
        },
        duration = 6,
        target = {
            select = 'party',
            type = 'one'
        },
        text = 'Temporarily increases the defense of a party member.'
    }
}