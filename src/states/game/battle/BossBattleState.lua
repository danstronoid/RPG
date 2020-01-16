--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Boss Battle State --

    This state inherits from the Battle State.  The difference being that 
    this state instantiates the boss and not a party of enemies.  At the end of
    the battle an 'endOfGame' event is dispatched.
]]

BossBattleState = Class{__includes = BattleState}

function BossBattleState:init(player)
    BattleState.init(self, player)

    self.enemies = {Enemy(BOSS_DEFS['Trolgus'])}
    
    self:setPositions()
end

function BossBattleState:exit()
    Event.dispatch('endOfGame')
end
