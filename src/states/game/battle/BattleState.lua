

BattleState = Class{__includes = BaseState}

function BattleState:init(player)
    self.player = player

    self.party = player.party
    self.charAnims = {}
    for i = 1, #self.party.members do
        self.charAnims[i] = self.party.members[i].animations.battle
    end

    self.enemies = {}
    for i = 1, math.random(3) do
        self.enemies[i] = Enemy(ENEMY_DEFS['dingus'])
    end

    self.panel = Panel(0, 2 * (VIRTUAL_HEIGHT / 3), VIRTUAL_WIDTH, VIRTUAL_HEIGHT / 3, GREY)
end

function BattleState:enter()
    gStateStack:push(BattleMenuState(self.party, self.enemies))
end

function BattleStateUpdate(dt)

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
