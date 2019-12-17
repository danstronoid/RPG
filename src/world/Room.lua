--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Room --
]]

Room = Class{}

-- create a table of booleans to reprsent where on the map to spawn a room
function Room:init(mapWidth, mapHeight, corridor)
    self.tiles = {}
    self.width = 8 --math.random(5, 10)
    self.height = 8 --math.random(5, 10)

    -- use an offset to ensure one empty tile of padding around the map
    self.x = mapWidth / 2 --+ math.random(4)
    self.y = mapHeight / 2 --+ math.random(4)
    
    self.corridor = corridor or false

    -- if passed the previous corridor, then adjust the position accordingly
    if self.corridor then
        if corridor.type == 'left' then
            self.x = corridor.x - self.width
            self.y = corridor.y
        elseif corridor.type == 'right' then
            self.x = corridor.x + corridor.width
            self.y = corridor.y
        elseif corridor.type == 'top' then
            self.x = corridor.x
            self.y = corridor.y - self.height
        else
            self.x = corridor.x
            self.y = corridor.y + corridor.width
        end
    end

    for y = 1, mapHeight do
        table.insert(self.tiles, {})

        for x = 1, mapWidth do
            if y >= self.y and y <= (self.height + self.y) and 
                x >= self.x and x <= (self.width + self.x) then
                table.insert(self.tiles[y], true)
            else
                table.insert(self.tiles[y], false)
            end
        end
    end
end