--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Dependencies --
]]

-- libraries
Class = require 'lib/class'
Push = require 'lib/push'
Event = require 'lib/knife.event'
Timer = require 'lib/knife.timer'

-- misc
require 'src/constants'
require 'src/util'

-- state machine
require 'src/states/BaseState'
require 'src/states/StateStack'

-- game states
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- world
require 'src/world/Tile'
require 'src/world/tileIDs'
require 'src/world/TileMap'
require 'src/world/Level'

-- textures
gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/temp/sheet.png')
}

-- frames
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE)
}

-- fonts
gFonts = {
    ['xsmall'] = love.graphics.newFont('fonts/CT.ttf', 8),
    ['small'] = love.graphics.newFont('fonts/CT.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/CT.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/CT.ttf', 64)
}
