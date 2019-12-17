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
require 'src/Camera'
require 'src/Animation'

-- state machine
require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/StateMachine'

-- game states
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- entity states
require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'

-- entites
require 'src/entities/Entity'
require 'src/entities/entity_defs'

-- world
require 'src/world/Tile'
require 'src/world/tileIDs'
require 'src/world/TileMap'
require 'src/world/Level'
require 'src/world/generateDungeon'
require 'src/world/Room'
require 'src/world/Corridor'

-- textures
gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/temp/sheet.png'),
    ['entities'] = love.graphics.newImage('graphics/temp/entities.png')
}

-- frames
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['entities'] = GenerateQuads(gTextures['entities'], TILE_SIZE, TILE_SIZE)
}

-- fonts
gFonts = {
    ['xsmall'] = love.graphics.newFont('fonts/CT.ttf', 8),
    ['small'] = love.graphics.newFont('fonts/CT.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/CT.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/CT.ttf', 64)
}
