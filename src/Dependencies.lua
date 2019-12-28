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
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/DialogueState'
require 'src/states/game/GameOverState'

-- field states
require 'src/states/game/field/FieldMenuState'
require 'src/states/game/field/StatsMenuState'

-- battle states
require 'src/states/game/battle/BattleState'
require 'src/states/game/battle/TurnState'
require 'src/states/game/battle/BattleMenuState'
require 'src/states/game/battle/BattleMessageState'
require 'src/states/game/battle/EnemyTurnState'
require 'src/states/game/battle/AttackMenuState'
require 'src/states/game/battle/BattleItemState'
require 'src/states/game/battle/BattleVictoryState'

-- entity states
require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'

-- entites
require 'src/entities/Entity'
require 'src/entities/Character'
require 'src/entities/Stats'
require 'src/entities/character_stats'
require 'src/entities/character_anims'
require 'src/entities/Player'
require 'src/entities/Party'
require 'src/entities/Enemy'
require 'src/entities/enemy_defs'

-- world
require 'src/world/Tile'
require 'src/world/tileIDs'
require 'src/world/TileMap'
require 'src/world/Level'
require 'src/world/Dungeon'
require 'src/world/Room'
require 'src/world/Corridor'

-- GUI
require 'src/GUI/Panel'
require 'src/GUI/Textbox'
require 'src/GUI/Selection'
require 'src/GUI/Menu'
require 'src/GUI/Number'

-- textures
gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/cave.png'),
    ['battle'] = love.graphics.newImage('graphics/cave_battle.png'),
    ['cursor'] = love.graphics.newImage('graphics/cursor.png'),
    ['entities'] = love.graphics.newImage('graphics/temp/entities.png'),
    ['man'] = love.graphics.newImage('graphics/healer_m_16.png'),
    ['woman'] = love.graphics.newImage('graphics/townfolk1_f_16.png'),
    ['octopus'] = love.graphics.newImage('graphics/octopus.png')
}

-- frames
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['entities'] = GenerateQuads(gTextures['entities'], TILE_SIZE, TILE_SIZE),
    ['man'] = GenerateQuads(gTextures['man'], 16, 18),
    ['woman'] = GenerateQuads(gTextures['man'], 16, 18)
}

-- fonts
gFonts = {
    ['xsmall'] = love.graphics.newFont('fonts/CT.ttf', 8),
    ['small'] = love.graphics.newFont('fonts/CT.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/CT.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/CT.ttf', 64)
}
