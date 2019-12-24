

BattleState = Class{__includes = BaseState}

function BattleState:init(player)
    self.player = player

    self.party = player.party
    self.charAnims = {}
    for i = 1, #self.party.members do
        self.charAnims[i] = self.party.members[i].animations.battle
    end

    -- generate a table of enemies
    self.enemies = {}
    for i = 1, math.random(3) do
        self.enemies[i] = Enemy(ENEMY_DEFS['dingus'])
        self.enemies[i].name = self.enemies[i].name .. ' ' .. i
    end

    self.panel = Panel(0, 2 * (VIRTUAL_HEIGHT / 3), VIRTUAL_WIDTH, VIRTUAL_HEIGHT / 3, GREY)

    self.turnStarted = false
    self.turnCounter = 1
    self.turnOrder = sortTurns(self.party, self.enemies)
end

function BattleState:enter()

end

function BattleState:update(dt)
    if not self.turnStarted then
        if self.turnCounter > #self.turnOrder then
            self.turnOrder = sortTurns(self.party, self.enemies)
            self.turnCounter = 1
        end
        self:takeTurn()
    end 
end

function BattleState:render()

    -- draw background
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(gTextures['battle'], 0, TILE_SIZE * 2 - VIRTUAL_HEIGHT / 3)

    self.panel:render()

    for i = 1, #self.party.members do
        local xPos = math.floor(VIRTUAL_WIDTH / 4 - (i - 1) * TILE_SIZE / 2)
        -- the padded height above the battle menu, TILE_SIZE is used as padding here to make the party closer together
        local gapHeight = (2 * (VIRTUAL_HEIGHT / 3) - TILE_SIZE * 2) / #self.party.members
        -- spread the pary evenly across the y-axis, the height of a character sprite is 18
        local yPos = math.floor(gapHeight / 2 * (i * 2 - 1) - 18 / 2 + TILE_SIZE)

        love.graphics.draw(gTextures[self.charAnims[i].texture], gFrames[self.charAnims[i].texture][self.charAnims[i].frame], 
            xPos, yPos)
    end

    for i = 1, #self.enemies do
        local xPos = 0
        -- the padded height above the battle menu
        local gapHeight = (2 * (VIRTUAL_HEIGHT / 3) - PADDING) / #self.enemies

        -- spread the enemies evenly across the y-axis
        local yPos = math.floor(gapHeight / 2 * (i * 2 - 1) - self.enemies[i].height / 2 + PADDING / 2)

        -- altenate enemies between front and back
        if i % 2 == 0 then
            xPos = math.floor(VIRTUAL_WIDTH - (VIRTUAL_WIDTH / 4))
        else
            xPos = math.floor(VIRTUAL_WIDTH - (VIRTUAL_WIDTH / 4) - self.enemies[i].width)
        end

        love.graphics.draw(gTextures[self.enemies[i].texture], xPos, yPos)
    end
end

function BattleState:takeTurn()
    self.turnStarted = true

    local index
    local playerTurn = false
    for j = 1, #self.party.members do
        if self.party.members[j].name == self.turnOrder[self.turnCounter].name then
            index = j
            playerTurn = true
        end
    end

    for k = 1, #self.enemies do
        if self.enemies[k].name == self.turnOrder[self.turnCounter].name then
            index = k           
        end
    end
    
    -- if this has been flagged as a player turn, push a battle menu, 
    -- otherwise push an enemy turn
    if playerTurn then
        gStateStack:push(BattleMenuState(self.party, self.enemies, index))
    else
        gStateStack:push(EnemyTurnState(self.party, self.enemies, index))
    end

    self.turnStarted = false
    self.turnCounter = self.turnCounter + 1
end

-- returns a table of the order for this turn
-- turn order is calculated by comparing speed stat plus a 1D6 roll
function sortTurns(party, enemies)

    local turnOrder = {}

    for i = 1, #party.members do
        local entity = {
            name = party.members[i].name,
            spd = party.members[i].stats.spd + math.random(6)
        }
        table.insert(turnOrder, entity)
    end

    for i = 1, #enemies do
        local entity = {
            name = enemies[i].name,
            spd = enemies[i].stats.spd + math.random(6)
        }
        table.insert(turnOrder, entity)
    end

    table.sort(turnOrder, function (k1, k2) return k1.spd > k2.spd end)

    for i, entity in pairs(turnOrder) do
        print(entity.name .. ', ' .. entity.spd)
    end
    print('\n')

    return turnOrder
end
