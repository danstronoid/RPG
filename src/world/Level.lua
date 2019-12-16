--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Level --
]]

Level = Class{}

function Level:init()
    self.tileMapWidth = 24
    self.tileMapHeight = 50

    self.base = TileMap(self.tileMapWidth, self.tileMapHeight)

    self:createMap()

    self.player = Entity {
        mapX = (VIRTUAL_WIDTH / TILE_SIZE) / 2 + 1,
        mapY = (VIRTUAL_HEIGHT / TILE_SIZE) / 2 + 1,
        width = 16,
        height = 16,
        animations = ENTITY_DEFS['player'].animations
    }

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }
    self.player.stateMachine:change('idle')

end

function Level:createMap()
    for y = 1, self.tileMapHeight do
        table.insert(self.base.tiles, {})

        for x = 1, self.tileMapWidth do
            local id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]

            table.insert(self.base.tiles[y], Tile(x, y, id))
        end
    end
end

function Level:update(dt) 
    self.player:update(dt)
end

function Level:render(camera)
    self.base:render(camera)
    self.player:render(camera)
end