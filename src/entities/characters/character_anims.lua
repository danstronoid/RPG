--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- character animations--

    This table defines all of the animations, both field and battle for all 
    of the character sprites.

]]

CHARACTER_ANIMS = {
    ['Zappa'] = {
        field = {
            ['walk-left'] = {
                texture = 'man',
                frames = {10, 11, 12, 11},
                interval = 0.15
            },
            ['walk-right'] = {
                texture = 'man',
                frames = {4, 5, 6, 5},
                interval = 0.15
            },
            ['walk-down'] = {
                texture = 'man',
                frames = {7, 8, 9, 8},
                interval = 0.15
            },
            ['walk-up'] = {
                texture = 'man',
                frames = {1, 2, 3, 2},
                interval = 0.15
            },
            ['idle-left'] = {
                texture = 'man',
                frames = {11}
            },
            ['idle-right'] = {
                texture = 'man',
                frames = {5}
            },
            ['idle-down'] = {
                texture = 'man',
                frames = {8}
            },
            ['idle-up'] = {
                texture = 'man',
                frames = {2}
            },
        },
        battle = {
            texture = 'man',
            frame = 5
        }
    },
    ['Moon'] = {
        field = {
            ['walk-left'] = {
                texture = 'woman',
                frames = {10, 11, 12, 11},
                interval = 0.15
            },
            ['walk-right'] = {
                texture = 'woman',
                frames = {4, 5, 6, 5},
                interval = 0.15
            },
            ['walk-down'] = {
                texture = 'woman',
                frames = {7, 8, 9, 8},
                interval = 0.15
            },
            ['walk-up'] = {
                texture = 'woman',
                frames = {1, 2, 3, 2},
                interval = 0.15
            },
            ['idle-left'] = {
                texture = 'woman',
                frames = {11}
            },
            ['idle-right'] = {
                texture = 'woman',
                frames = {5}
            },
            ['idle-down'] = {
                texture = 'woman',
                frames = {8}
            },
            ['idle-up'] = {
                texture = 'woman',
                frames = {2}
            },
        },
        battle = {
            texture = 'woman',
            frame = 5
        }
    }
}