--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Turn State --

    This state is pushed from the battle state and should remain on the stack
    until the battle has ended.  This state generates an order for entities 
    to take turns and pushes each turn until the each entity has taken a turn.
    Then the turn order is recalculated and the loop continues until either the
    party is defeated or the enemies are defeated.
]]


TurnState = Class{__includes = BaseState}

function TurnState:init(battleState)
    self.player = battleState.player
    self.party = battleState.party
    self.enemies = battleState.enemies

    self.turnStarted = false
    self.turnIndex = 1 -- this counter rolls over after each entity has taken a turn
    self.turnOrder = sortTurns(self.party, self.enemies)

    -- halt all turns if we've reached the end of the battle
    self.endOfBattle = false
end

-- reset the turn counter at the end of the battle, 
-- this also removes any counters that were active
function TurnState:exit()
    TurnCounter:reset()
end

function TurnState:update(dt)
    self:checkDeaths()
    if not self.turnStarted and not self.endOfBattle then
        self:takeTurn()
    end 
end

-- push a turn and increment the turn counter
function TurnState:takeTurn()
    self.turnStarted = true

    for j = 1, #self.party.members do
        if self.party.members[j].name == self.turnOrder[self.turnIndex].name 
            and not self.party.members[j].dead then
                TurnCounter:increment()
                gStateStack:push(BattleMenuState(self.player, self.enemies, j))
        end
    end

    for k = 1, #self.enemies do
        if self.enemies[k].name == self.turnOrder[self.turnIndex].name 
            and not self.enemies[k].dead then
                TurnCounter:increment()
                gStateStack:push(EnemyTurnState(self.party, self.enemies, k))      
        end
    end

    self.turnIndex = self.turnIndex + 1

    if self.turnIndex > #self.turnOrder then
        self.turnOrder = sortTurns(self.party, self.enemies)
        self.turnIndex = 1
    end

    self.turnStarted = false
end

-- check if any entities have died and then 
-- check for victory or defeat
function TurnState:checkDeaths()
    local deadEnemies = 0
    for i = 1, #self.enemies do
        if self.enemies[i].dead then
            deadEnemies = deadEnemies + 1
        elseif self.enemies[i].currentHP <= 0 then
            self.enemies[i].dead = true
            deadEnemies = deadEnemies + 1
        end
    end

    local deadMembers = 0
    for i = 1, #self.party.members do
        if self.party.members[i].dead then
            deadMembers = deadMembers + 1
        elseif self.party.members[i].currentHP <=0 then 
            self.party.members[i].currentHP = 0
            self.party.members[i].dead = true
            
            -- remove any stat mods
            self.party.members[i].stats:clearTempMods()
            deadMembers = deadMembers + 1
            --gStateStack:push(BattleMessageState(self.party.members[i].name .. ' has fallen.', function() end))     
        end
    end

    if deadEnemies == #self.enemies then
        self.endOfBattle = true 
        gMusic['battle']:stop()
        gMusic['battle_victory']:play()       
        gStateStack:push(BattleMessageState('The enemies have been defeated!', 
        function()
            gStateStack:pop()
            gStateStack:push(BattleVictoryState(self.player, self.enemies))
        end))

    end

    if deadMembers == #self.party.members then
        self.endOfBattle = true
        gStateStack:push(BattleMessageState('You have been defeated.', 
        function()
            gStateStack:push(FadeInState(BLACK, 1, true, function()
                -- pop off the turn, battle, and playstate
                gStateStack:pop()
                gStateStack:pop()
                gStateStack:pop()
                gStateStack:push(GameOverState())
                gStateStack:push(FadeOutState(BLACK, 1, false))
            end))
        end))
    end
end

-- returns a table of the turn order for this round
-- turn order is calculated by comparing speed stat plus a 1D3 roll
function sortTurns(party, enemies)

    local turnOrder = {}

    for i = 1, #party.members do
        if not party.members[i].dead then
            local entity = {
                name = party.members[i].name,
                spd = party.members[i].stats.spd + math.random(3)
            }
            table.insert(turnOrder, entity)
        end
    end

    for i = 1, #enemies do
        if not enemies[i].dead then
            local entity = {
                name = enemies[i].name,
                spd = enemies[i].stats.spd + math.random(3)
            }
            table.insert(turnOrder, entity)
        end
    end

    table.sort(turnOrder, function (k1, k2) return k1.spd > k2.spd end)

    --[[for i, entity in pairs(turnOrder) do
        print(entity.name .. ', ' .. entity.spd)
    end
    print('\n')]]

    return turnOrder
end
