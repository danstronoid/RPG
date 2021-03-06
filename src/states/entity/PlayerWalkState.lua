--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- PlayerWalkState --

    This state inherits from the Entity Walk State with the difference
    being that this state also checks for encounters.  The chance of an
    encounter increases depending on how many steps the player has taken
    since their last encounter.
]]


PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, level)
    EntityWalkState.init(self, player, level)
    self.player = player
    self.encounter = false
end

function PlayerWalkState:enter(callback)
    -- this optional callback can be used if you want to control the player's movements
    -- in a cut scene
    self.callback = callback or function() self.player:changeState('idle') end

    --print(self.entity.steps)
    self:checkEncounter()

    if not self.encounter then
        self:move()
    end
end

function PlayerWalkState:checkEncounter()
    local chanceEncounter = 0
    local steps = self.player.steps 

    if steps < 3 then
        chanceEncounter = 500
    elseif steps >= 3 and steps <= 5 then
        chanceEncounter = 40
    elseif steps > 5 and steps <= 10 then
        chanceEncounter = 20
    elseif steps > 10 and steps <= 20 then
        chanceEncounter = 10
    else 
        chanceEncounter = 3
    end

    if math.random(chanceEncounter) == 1 then
        self.player:changeState('idle')
        gMusic['dungeon']:pause()

        gStateStack:push(BattleTransState(BLACK, 1, 
            function()
                gStateStack:push(BattleState(self.player))
            end))
        self.encounter = true
        self.player.steps = 0
    else 
        self.encounter = false
    end
end
