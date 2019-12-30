


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
    }
}