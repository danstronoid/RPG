


ITEM_DEFS = {
    ['potion'] = {
        name = 'Potion',
        type = 'consumable',
        action = 'item_restoreHP',
        target = {
            select = 'party',
            type = 'one'
        },
        restore = 40,
        price = 10
    }



}