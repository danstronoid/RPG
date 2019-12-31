


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
        description = 'Damage an enemy with fire.'
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
        description = 'Damage an enemy with ice.'
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
        description = 'Restores a small amount of HP to a party member.'
    },
    ['Protect'] = {
        name = 'Protect',
        action = 'buff_spell',
        mp_cost = 4,
        mod = {
            mult = {['dfn'] = 1}
        },
        duration = 2,
        target = {
            select = 'party',
            type = 'one'
        },
        description = 'Temporarily increases the defense of a party member.'
    }
}