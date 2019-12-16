--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Tile --

    Class representing an individual tile.
]]

Tile = Class{}

function Tile:init(x, y, id)
    self.x = x
    self.y = y
    self.id = id
end

function Tile:render(camera)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id],
        math.floor((self.x - 1) * TILE_SIZE - camera.offsetX), math.floor((self.y - 1) * TILE_SIZE - camera.offsetY))
end