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

-- create a global turn counter for timing battle callbacks
require 'src/TurnCounter'
TurnCounter = TurnCounter()

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
require 'src/states/game/PopUpState'
require 'src/states/game/GameOverState'
require 'src/states/game/BattleTransState'

-- field states
require 'src/states/game/field/FieldMenuState'
require 'src/states/game/field/StatsMenuState'
require 'src/states/game/field/ItemMenuState'

-- battle states
require 'src/states/game/battle/BattleState'
require 'src/states/game/battle/BossBattleState'
require 'src/states/game/battle/TurnState'
require 'src/states/game/battle/BattleMenuState'
require 'src/states/game/battle/BattleMessageState'
require 'src/states/game/battle/TargetSelectState'
require 'src/states/game/battle/EnemyTurnState'
require 'src/states/game/battle/AttackState'
require 'src/states/game/battle/BattleMagicState'
require 'src/states/game/battle/BattleItemState'
require 'src/states/game/battle/BattleVictoryState'

-- entity states
require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'

-- items
require 'src/items/item_defs'
require 'src/items/Inventory'

-- magic
require 'src/magic/magic_defs'
require 'src/magic/Magic'

-- entites
require 'src/entities/Entity'
require 'src/entities/NPC'
require 'src/entities/npc_defs'
require 'src/entities/Character'
require 'src/entities/Stats'
require 'src/entities/character_stats'
require 'src/entities/character_magic'
require 'src/entities/character_anims'
require 'src/entities/Player'
require 'src/entities/Party'
require 'src/entities/Enemy'
require 'src/entities/enemy_defs'
require 'src/entities/actions'

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
require 'src/GUI/PopUp'
require 'src/GUI/Selection'
require 'src/GUI/Menu'
require 'src/GUI/Number'

-- textures
gTextures = {
    -- world
    ['tiles'] = love.graphics.newImage('graphics/cave.png'),
    ['battle'] = love.graphics.newImage('graphics/cave_battle.png'),
    -- GUI
    ['cursor'] = love.graphics.newImage('graphics/cursor.png'),
    -- characters
    ['man'] = love.graphics.newImage('graphics/healer_m_16.png'),
    ['woman'] = love.graphics.newImage('graphics/townfolk1_f_16.png'),
    -- enemies
    ['octopus'] = love.graphics.newImage('graphics/enemies/octopus.png'),
    ['lg_alien'] = love.graphics.newImage('graphics/enemies/lg_alien.png'),
    ['alien_16'] = love.graphics.newImage('graphics/enemies/alien_16.png'),
    ['sm_alien'] = love.graphics.newImage('graphics/enemies/sm_alien.png'),
    ['mush_man'] = love.graphics.newImage('graphics/enemies/mush_man.png'),
    ['tent_head'] = love.graphics.newImage('graphics/enemies/tent_head.png')

}

-- frames
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['man'] = GenerateQuads(gTextures['man'], 16, 18),
    ['woman'] = GenerateQuads(gTextures['man'], 16, 18),
    ['alien_16'] = GenerateQuads(gTextures['alien_16'], 16, 18)
}

-- fonts
gFonts = {
    ['xsmall'] = love.graphics.newFont('fonts/CT.ttf', 8),
    ['small'] = love.graphics.newFont('fonts/CT.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/CT.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/CT.ttf', 64),
    ['title'] = love.graphics.newFont('fonts/title.ttf', 56)
}
