

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

    self:setPositions()

    self.panel = Panel(0, 2 * (VIRTUAL_HEIGHT / 3), VIRTUAL_WIDTH, VIRTUAL_HEIGHT / 3, GREY)
end

function BattleState:enter()
    gStateStack:push(FadeOutState(BLACK, 1, 
    function ()
        gStateStack:push(BattleMessageState('A group of enemies appeared!', 
        function()
            gStateStack:push(TurnState(self))
        end))
    end))  
end

function BattleState:render()

    -- draw background
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(gTextures['battle'], 0, TILE_SIZE * 2 - VIRTUAL_HEIGHT / 3)

    self.panel:render()

    for i = 1, #self.party.members do
        if not self.party.members[i].dead then
            love.graphics.setColor(255, 255, 255, self.party.members[i].opacity)
            love.graphics.draw(gTextures[self.charAnims[i].texture], gFrames[self.charAnims[i].texture][self.charAnims[i].frame], 
            self.party.members[i].x, self.party.members[i].y)
        end
    end

    for i = 1, #self.enemies do
        if not self.enemies[i].dead then
            love.graphics.setColor(255, 255, 255, self.enemies[i].opacity)
            love.graphics.draw(gTextures[self.enemies[i].texture], self.enemies[i].x, self.enemies[i].y)
        end
    end
end

function BattleState:setPositions()
    for i = 1, #self.party.members do
        self.party.members[i].x = math.floor(VIRTUAL_WIDTH / 4 - (i - 1) * TILE_SIZE / 2)
        -- the padded height above the battle menu, TILE_SIZE is used as padding here to make the party closer together
        local gapHeight = (2 * (VIRTUAL_HEIGHT / 3) - TILE_SIZE * 2) / #self.party.members
        -- spread the pary evenly across the y-axis, the height of a character sprite is 18
        self.party.members[i].y = math.floor(gapHeight / 2 * (i * 2 - 1) - 18 / 2 + TILE_SIZE + PADDING)
    end

    for i = 1, #self.enemies do
        -- the padded height above the battle menu
        local gapHeight = (2 * (VIRTUAL_HEIGHT / 3) - TILE_SIZE * 2) / #self.enemies

        -- spread the enemies evenly across the y-axis
        self.enemies[i].y = math.floor(gapHeight / 2 * (i * 2 - 1) - self.enemies[i].height / 2 + TILE_SIZE + PADDING)

        -- altenate enemies between front and back
        if i % 2 == 0 then
            self.enemies[i].x = math.floor(VIRTUAL_WIDTH - (VIRTUAL_WIDTH / 4))
        else
            self.enemies[i].x = math.floor(VIRTUAL_WIDTH - (VIRTUAL_WIDTH / 4) - self.enemies[i].width)
        end
    end
end