--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- entity definitions--

]]

ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['walk-left'] = {
                texture = 'entities',
                frames = {16, 17, 18, 17},
                interval = 0.15
            },
            ['walk-right'] = {
                texture = 'entities',
                frames = {28, 29, 30, 29},
                interval = 0.15
            },
            ['walk-down'] = {
                texture = 'entities',
                frames = {4, 5, 6, 5},
                interval = 0.15
            },
            ['walk-up'] = {
                texture = 'entities',
                frames = {40, 41, 42, 41},
                interval = 0.15
            },
            ['idle-left'] = {
                texture = 'entities',
                frames = {17}
            },
            ['idle-right'] = {
                texture = 'entities',
                frames = {29}
            },
            ['idle-down'] = {
                texture = 'entities',
                frames = {5}
            },
            ['idle-up'] = {
                texture = 'entities',
                frames = {41}
            },
        }
    }
}