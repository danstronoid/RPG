--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Room --

    This class is used to create a new room starting from the last corridor, or creates the first room.
    The room is a table of booleans in a 2D array of size equal to the map dimensions.
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
    if (self.x + self.width) >= (mapWidth - PADDING_TILE) then
        self.x = mapWidth - PADDING_TILE - self.width 
    elseif self.x <= PADDING_TILE then
        self.x = PADDING_TILE + 1
    end

    if (self.y + self.height) >= (mapHeight - PADDING_TILE) then
        self.y = mapHeight - PADDING_TILE - self.height 
    elseif self.y <= PADDING_TILE then
        self.y = PADDING_TILE + 1
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