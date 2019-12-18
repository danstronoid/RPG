--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Room --
]]

Corridor = Class{}

CORRIDOR_TYPES = {'top', 'bottom', 'left', 'right'}

function Corridor:init(mapWidth, mapHeight, room)
    self.tiles = {}

    self.type = CORRIDOR_TYPES[math.random(4)]
    --print(self.type)    

    local smDim = math.random(2)
    local lgDim = math.random(6, 10)

    if self.type == 'top' then
        self.width = smDim
        self.height = lgDim 
        self.x = room.x + math.random(0, room.width - self.width)
        self.y = room.y - self.height
    elseif self.type == 'bottom' then
        self.width = smDim
        self.height = lgDim 
        self.x = room.x + math.random(0, room.width - self.width)
        self.y = room.y + room.height
    elseif self.type == 'left' then
        self.width = lgDim
        self.height = smDim 
        self.x = room.x - self.width
        self.y = room.y + math.random(0, room.height - self.height)
    else
        self.width = lgDim
        self.height = smDim 
        self.x = room.x + room.width
        self.y = room.y + math.random(0, room.height - self.height)
    end

    -- guard to make sure a corridor isn't created outside of the map boundries
    -- use one tile of padding around the map
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
