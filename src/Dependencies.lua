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
Chain = require 'lib/knife.chain'

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
require 'src/states/game/VictoryState'
require 'src/states/game/PartyDialogueState'

-- field states
require 'src/states/game/field/FieldMenuState'
require 'src/states/game/field/StatsMenuState'
require 'src/states/game/field/ItemMenuState'
require 'src/states/game/field/ShopMenuState'

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
require 'src/items/Chest'

-- magic
require 'src/magic/magic_defs'
require 'src/magic/Magic'

-- entites
require 'src/entities/Entity'
require 'src/entities/Stats'
require 'src/entities/Player'
require 'src/entities/Party'
require 'src/entities/actions'
-- characters
require 'src/entities/characters/character_stats'
require 'src/entities/characters/character_magic'
require 'src/entities/characters/character_anims'
require 'src/entities/characters/Character'
-- enemies
require 'src/entities/enemies/Enemy'
require 'src/entities/enemies/enemy_defs'
-- npc
require 'src/entities/npc/NPC'
require 'src/entities/npc/npc_defs'


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
    ['woman'] = love.graphics.newImage('graphics/mage_f_16.png'),

    -- NPC
    ['merchant'] = love.graphics.newImage('graphics/townfolk1_m_16.png'),
    ['boss'] = love.graphics.newImage('graphics/enemies/boss.png'),

    -- enemies
    ['octopus'] = love.graphics.newImage('graphics/enemies/octopus.png'),
    ['lg_alien'] = love.graphics.newImage('graphics/enemies/lg_alien.png'),
    ['sm_alien'] = love.graphics.newImage('graphics/enemies/sm_alien.png'),
    ['mush_man'] = love.graphics.newImage('graphics/enemies/mush_man.png'),
    ['tent_head'] = love.graphics.newImage('graphics/enemies/tent_head.png'),

    -- items
    ['items'] = love.graphics.newImage('graphics/items.png')

}

-- frames
gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['man'] = GenerateQuads(gTextures['man'], 16, 18),
    ['woman'] = GenerateQuads(gTextures['man'], 16, 18),
    ['merchant'] = GenerateQuads(gTextures['merchant'], 16, 18),
    ['boss'] = GenerateQuads(gTextures['boss'], 16, 18),
    ['items'] = GenerateQuads(gTextures['items'], 16, 16)
}

-- fonts
gFonts = {
    ['xsmall'] = love.graphics.newFont('fonts/CT.ttf', 8),
    ['small'] = love.graphics.newFont('fonts/CT.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/CT.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/CT.ttf', 64),
    ['title'] = love.graphics.newFont('fonts/title.ttf', 56)
}

-- music
gMusic = {
    ['intro'] = love.audio.newSource('sounds/music/Overture_Mockup.wav'),
    ['gameover'] = love.audio.newSource('sounds/music/GameOver_Mockup.wav'),
    ['dungeon'] = love.audio.newSource('sounds/music/Dungeon_Mockup.wav'),
    ['battle'] = love.audio.newSource('sounds/music/Battle_Mockup.wav'),
    ['battle_trans'] = love.audio.newSource('sounds/music/Battle_Trans_Mockup.wav'),
    ['battle_victory'] = love.audio.newSource('sounds/music/Battle_Victory_Mockup.wav')
}

-- sound fx
gSfx = {
    ['menu_nav'] = love.audio.newSource('sounds/sfx/menu_nav.wav'),
    ['menu_select'] = love.audio.newSource('sounds/sfx/menu_select.wav'),
    ['fail'] = love.audio.newSource('sounds/sfx/fail.wav'),
    ['hit'] = love.audio.newSource('sounds/sfx/hit.wav'),
    ['hurt'] = love.audio.newSource('sounds/sfx/hurt.wav'),
    ['elemental'] = love.audio.newSource('sounds/sfx/elemental_spell.wav'),
    ['heal'] = love.audio.newSource('sounds/sfx/heal.wav'),
    ['step'] = love.audio.newSource('sounds/sfx/step.wav'),
    ['death'] = love.audio.newSource('sounds/sfx/death.wav')
}