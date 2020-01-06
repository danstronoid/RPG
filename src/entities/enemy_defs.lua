--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- enemy definitions--

    This table defines all of the stats and definitions
    relevant to each enemy.

]]
ENEMY_PARTIES = {
    [1] = {'Glomulorme', 'Fungurkk', 'Mukgnarre', 'Krolk'}
}

ENEMY_DEFS = {
    ['Glomulorme'] = {
        name = 'Glomulorme',
        stats = {
            baseHP = 8,
            baseMP = 4,
            baseStr = 1,
            baseInt = 0,
            baseSpd = 3,
            baseDfn = 2,
            HPIV = 5, 
            MPIV = 3,
            strIV = 4,
            intIV = 2,
            spdIV = 3,
            dfnIV = 3
        },
        texture = 'octopus',
        width = 48,
        height = 48,
        level = 2,
        weak = 'fire',
        magic = {'Heal'},
        XPDrop = 500,
        goldDrop = 20,
        itemDrop = 'Potion',
        itemChance = 6     
    },
    ['Fungurkk'] = {
        name = 'Fungurkk',
        stats = {
            baseHP = 6,
            baseMP = 0,
            baseStr = 1,
            baseInt = 0,
            baseSpd = 5,
            baseDfn = 4,
            HPIV = 4, 
            MPIV = 3,
            strIV = 3,
            intIV = 1,
            spdIV = 5,
            dfnIV = 4
        },
        texture = 'mush_man',
        width = 56,
        height = 56,
        level = 2,
        weak = 'fire',
        magic = {},
        XPDrop = 300,
        goldDrop = 10,
        itemDrop = 'Potion',
        itemChance = 8     
    },
    ['Mukgnarre'] = {
        name = 'Mukgnarre',
        stats = {
            baseHP = 4,
            baseMP = 0,
            baseStr = 3,
            baseInt = 0,
            baseSpd = 5,
            baseDfn = 2,
            HPIV = 3, 
            MPIV = 3,
            strIV = 4,
            intIV = 1,
            spdIV = 5,
            dfnIV = 1
        },
        texture = 'sm_alien',
        width = 56,
        height = 56,
        level = 2,
        weak = '',
        magic = {},
        XPDrop = 500,
        goldDrop = 10,
        itemDrop = 'Potion',
        itemChance = 6    
    },
    ['Krolk'] = {
        name = 'Krolk',
        stats = {
            baseHP = 7,
            baseMP = 12,
            baseStr = 1,
            baseInt = 4,
            baseSpd = 1,
            baseDfn = 2,
            HPIV = 4, 
            MPIV = 4,
            strIV = 2,
            intIV = 5,
            spdIV = 2,
            dfnIV = 3
        },
        texture = 'tent_head',
        width = 88,
        height = 40,
        level = 2,
        weak = 'ice',
        magic = {'Fire'},
        XPDrop = 750,
        goldDrop = 25,
        itemDrop = 'Potion',
        itemChance = 6  
    },
}

BOSS_DEFS = {
    ['Trolgus'] = {
        stats = {
            baseHP = 200,
            baseMP = 40,
            baseStr = 10,
            baseInt = 10,
            baseSpd = 6,
            baseDfn = 10,
            HPIV = 0, 
            MPIV = 0,
            strIV = 0,
            intIV = 0,
            spdIV = 0,
            dfnIV = 0
        },
        name = 'Trolgus',
        texture = 'lg_alien',
        width = 82,
        height = 82,
        level = 1,
        weak = 'ice',
        magic = {'Fire'},
        XPDrop = 2000,
        goldDrop = 100,
        itemDrop = 'Potion',
        itemChance = 6  
    },
}