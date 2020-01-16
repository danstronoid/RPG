--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- tile IDs --

    This is a table of tile ids using the cave.png tileset.
]]

TILE_IDS = {
    ['ground'] = {145, 146, 161, 162},
    ['empty'] = 67,
    ['water'] = 51,
    ['dark'] = 55,
    --edges
    ['water-top-edge'] = 2,
    ['water-bot-edge'] = 34,
    ['water-left-edge'] = 17,
    ['water-right-edge'] = 19,
    -- inner corners
    ['water-top-left'] = 49,
    ['water-top-right'] = 50,
    ['water-bot-left'] = 65,
    ['water-bot-right'] = 66,
    -- corners
    ['water-top-left-corner'] = 1,
    ['water-top-right-corner'] = 3,
    ['water-bot-left-corner'] = 33,
    ['water-bot-right-corner'] = 35,

    -- wall edges
    ['wall-top-edge-1'] = {174, 175},
    ['wall-top-edge-2'] = {158, 159},
    ['wall-top-edge-3'] = {142, 143},
    ['wall-top-edge-4'] = {126, 127},
    ['wall-bot-edge'] = {62, 63},
    ['wall-left-edge'] = {23, 39},
    ['wall-left-edge-w'] = {56, 72},
    ['wall-right-edge'] = {24, 40},
    ['wall-right-edge-w'] = {57, 73},

    -- corners
    ['wall-top-left-corner'] = 7,
    ['wall-top-right-corner'] = 8,
    ['wall-bot-left-corner'] = 60,
    ['wall-bot-right-corner'] = 76,

    -- details
    ['rocks'] = {113, 116, 130, 148, 148, 148, 149, 149, 149},
    ['cracks'] = 132,
    ['hole'] = 147
}
