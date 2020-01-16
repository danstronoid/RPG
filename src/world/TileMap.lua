--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Tile Map --

    Class used as a container for a map of Tile objects. 
]]

TileMap = Class{}

function TileMap:init(width, height)
    self.tiles = {}
    self.width = width
    self.height = height
end

function TileMap:render(camera)
    for y = 1, self.height do
        for x = 1, self.width do
            -- check to make sure a tile exists at that location
            if self.tiles[y][x] then
                self.tiles[y][x]:render(camera)
            end
        end
    end
end