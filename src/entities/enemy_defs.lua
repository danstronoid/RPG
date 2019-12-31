--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- enemy definitions--

    This table defines all of the stats and definitions
    relevant to each enemy.

]]

ENEMY_DEFS = {
    ['dingus'] = {
        name = 'Dingus',
        stats = {
            baseHP = 8,
            baseMP = 0,
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
        weak = 'ice',
        XPDrop = 500,
        goldDrop = 20,
        itemDrop = 'Potion',
        itemChance = 6     
    },
}