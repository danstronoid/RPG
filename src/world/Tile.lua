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
    -- only render the tile if it's within the camera's view
    -- there is a margin of 4 tiles on each side
    local xPos = math.floor((self.x - 1) * TILE_SIZE)
    local yPos = math.floor((self.y - 1) * TILE_SIZE)
    if (xPos) > (camera.x + math.floor(camera.offsetX) - TILE_SIZE * 4) and 
        (xPos) < (camera.width + math.floor(camera.offsetX) + TILE_SIZE * 4) and
        (yPos) > (camera.y + math.floor(camera.offsetY) - TILE_SIZE * 4) and 
        (yPos) < (camera.height + math.floor(camera.offsetY) + TILE_SIZE * 4) then
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id],
                xPos, yPos, 0, 1, 1, math.floor(camera.offsetX), math.floor(camera.offsetY))
    end
end