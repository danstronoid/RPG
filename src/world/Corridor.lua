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
    self.last = last or false

    self.type = CORRIDOR_TYPES[math.random(4)]
    print(self.type)    

    if self.type == 'top' then
        self.width = 2
        self.height = 10 --math.random(8, 10)
        self.x = room.x + math.random(room.width - self.width)
        self.y = room.y - self.height
    elseif self.type == 'bottom' then
        self.width = 2
        self.height = 10 --math.random(8, 10)
        self.x = room.x + math.random(room.width - self.width)
        self.y = room.y + room.height
    elseif self.type == 'left' then
        self.width = 10
        self.height = 2 --math.random(8, 10)
        self.x = room.x - self.width
        self.y = room.y + math.random(room.height - self.height)
    else
        self.width = 10
        self.height = 2 --math.random(8, 10)
        self.x = room.x + room.width
        self.y = room.y + math.random(room.height - self.height)
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
