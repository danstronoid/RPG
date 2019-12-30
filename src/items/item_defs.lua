


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
    }



}