--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Level --
]]

Level = Class{}

function Level:init()
    self.tileMapWidth = 50
    self.tileMapHeight = 50

    self.base = TileMap(self.tileMapWidth, self.tileMapHeight)

    self:createMap()
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

function Level:update(dt) end

function Level:render()
    self.base:render()
end