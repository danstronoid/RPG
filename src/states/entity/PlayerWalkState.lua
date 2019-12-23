--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- PlayerWalkState --

]]


PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, level)
    EntityWalkState.init(self, player, level)
    self.player = player
    self.encounter = false
end

function PlayerWalkState:enter()
    self.player.steps = self.player.steps + 1
    --print(self.entity.steps)
    self:checkEncounter()

    if not self.encounter then
        self:move()
    end
end

function PlayerWalkState:checkEncounter()
    local chanceEncounter = 0
    local steps = self.player.steps 

    if steps <= 5 then
        chanceEncounter = 50
    elseif steps > 5 and steps <= 10 then
        chanceEncounter = 20
    elseif steps > 10 and steps <= 20 then
        chanceEncounter = 10
    else 
        chanceEncounter = 3
    end

    if math.random(chanceEncounter) == 1 then
        self.player:changeState('idle')

        gStateStack:push(FadeInState(BLACK, 1, 
            function()
                gStateStack:push(BattleState(self.player))
                gStateStack:push(FadeOutState(BLACK, 1))
            end))
        self.encounter = true
        self.player.steps = 0
    else 
        self.encounter = false
    end
end
