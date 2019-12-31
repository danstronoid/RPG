
TurnState = Class{__includes = BaseState}

function TurnState:init(battleState)
    self.player = battleState.player
    self.party = battleState.party
    self.enemies = battleState.enemies

    self.turnStarted = false
    self.turnCounter = 1 -- this counter rolls over after each entity has taken a turn
    self.turnOrder = sortTurns(self.party, self.enemies)
    self.turnTimer = 0 -- this is the total number of turns that have passed since the battle began

    -- halt all turns if we've reached the end of the battle
    self.endOfBattle = false
end

function TurnState:update(dt)
    self:checkDeaths()
    if not self.turnStarted and not self.endOfBattle then
        self:takeTurn()
    end 
end

function TurnState:takeTurn()
    self.turnStarted = true

    if self.turnCounter > #self.turnOrder then
        self.turnOrder = sortTurns(self.party, self.enemies)
        self.turnCounter = 1
    end

    for j = 1, #self.party.members do
        if self.party.members[j].name == self.turnOrder[self.turnCounter].name 
            and not self.party.members[j].dead then
                Event.dispatch('newTurn')
                gStateStack:push(BattleMenuState(self.player, self.enemies, j, self.turnTotal))
        end
    end

    for k = 1, #self.enemies do
        if self.enemies[k].name == self.turnOrder[self.turnCounter].name 
            and not self.enemies[k].dead then
                Event.dispatch('newTurn')
                gStateStack:push(EnemyTurnState(self.party, self.enemies, k))      
        end
    end

    self.turnStarted = false
    self.turnCounter = self.turnCounter + 1
    self.turnTimer = self.turnTimer + 1
end

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
            deadMembers = deadMembers + 1
            --gStateStack:push(BattleMessageState(self.party.members[i].name .. ' has fallen.', function() end))     
        end
    end

    if deadEnemies == #self.enemies then
        self.endOfBattle = true
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
            gStateStack:push(FadeInState(BLACK, 1, function()
                -- pop off the turn, battle, and playstate
                gStateStack:pop()
                gStateStack:pop()
                gStateStack:pop()
                gStateStack:push(GameOverState())
                gStateStack:push(FadeOutState(BLACK, 1))
            end))
        end))
    end
end

-- returns a table of the order for this turn
-- turn order is calculated by comparing speed stat plus a 1D6 roll
function sortTurns(party, enemies)

    local turnOrder = {}

    for i = 1, #party.members do
        if not party.members[i].dead then
            local entity = {
                name = party.members[i].name,
                spd = party.members[i].stats.spd + math.random(6)
            }
            table.insert(turnOrder, entity)
        end
    end

    for i = 1, #enemies do
        if not enemies[i].dead then
            local entity = {
                name = enemies[i].name,
                spd = enemies[i].stats.spd + math.random(6)
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
