--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Tile --

    Class representing an individual tile.
]]

Tile = Class{}

function Tile:init(x, y, id, solid)
    self.x = x
    self.y = y
    self.id = id

    -- use a flag to keep track of whether or not the tile is solid
    self.solid = solid or false
end

function Tile:render(camera)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id],
        math.floor((self.x - 1) * TILE_SIZE), math.floor((self.y - 1) * TILE_SIZE), 
        0, 1, 1, math.floor(camera.offsetX), math.floor(camera.offsetY))
end