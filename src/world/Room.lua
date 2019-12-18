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
    self.width = math.random(8, 12)
    self.height = math.random(8, 12)

    -- if this is the first room, create it in the middle of the map
    self.x = mapWidth / 2 
    self.y = mapHeight / 2 
    
    self.corridor = corridor or false

    -- if passed the previous corridor, then adjust the position accordingly
    if self.corridor then
        if corridor.type == 'left' then
            self.x = corridor.x - self.width
            self.y = corridor.y - math.random(0, self.height - corridor.height)
        elseif corridor.type == 'right' then
            self.x = corridor.x + corridor.width
            self.y = corridor.y - math.random(0, self.height - corridor.height)
        elseif corridor.type == 'top' then
            self.x = corridor.x - math.random(0, self.width - corridor.width)
            self.y = corridor.y - self.height
        else
            self.x = corridor.x - math.random(0, self.width - corridor.width)
            self.y = corridor.y + corridor.height
        end
    end

    -- guard to make sure a room isn't created outside of the map boundries
    -- use two tiles of padding around the map
    if (self.x + self.width) >= mapWidth then
        self.x = mapWidth - self.width - 2
    elseif self.x <= 2 then
        self.x = 3
    elseif (self.y + self.height) >= mapHeight then
        self.y = mapHeight - self.height - 2
    elseif self.y <= 2 then
        self.y = 3
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