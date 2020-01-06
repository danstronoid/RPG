


ITEM_DEFS = {
    ['Potion'] = {
        name = 'Potion',
        type = 'consumable',
        action = 'item_restoreHP',
        target = {
            select = 'party',
            type = 'one'
        },
        text = 'Heals a small amount of HP.',
        restore = 40,
        price = 10
    },
    ['Revive'] = {
        name = 'Revive',
        type = 'consumable',
        action = 'item_revive',
        target = {
            select = 'party',
            type = 'one',
            revive = true
        },
        text = 'Revives one fallen party member.',
        restore = 20,
        price = 100
    }



}