--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Item Defs --
    
    This is a table of all game items and their definitions.
    
    Each item is in the format:
    ['item name'] = {
        name = item name (needs to be consistent with table key),
        type = how the item can be used (consumable or equipment, etc),
        action = name of action function to call when used,
        target = {
            select = does it target the party or the enemies
            type = how many (one or all)
            revive = boolean for whether it can target dead characters
        },
        text = brief description,
        restore = how much health it restores,
        price = how much it costs to buy
    }
]]


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