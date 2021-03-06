--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Corridor --

    This class is used to create a new corridor starting from the last room.
    The corridor is a table of booleans in a 2D array of size equal to the map dimensions.
    The corridor branches off from the room in a random direction and the
    end of the corridor is the starting point for the next room.
]]

Corridor = Class{}

CORRIDOR_TYPES = {'top', 'bottom', 'left', 'right'}

function Corridor:init(mapWidth, mapHeight, room)
    self.tiles = {}

    self.type = CORRIDOR_TYPES[math.random(4)]
    --print(self.type)    

    -- prevent corridors from doubling back too much
    local counter = 0
    while room.corridor and room.corridor.opposite == self.type and counter < 3 do
        self.type = CORRIDOR_TYPES[math.random(4)]
        counter = counter + 1
    end

    local smDim = math.random(2)
    local lgDim = math.random(6, 10)

    if self.type == 'top' then
        self.opposite = 'bottom'
        self.width = smDim
        self.height = lgDim 
        self.x = room.x + math.random(0, room.width - self.width)
        self.y = room.y - self.height
    elseif self.type == 'bottom' then
        self.opposite = 'top'
        self.width = smDim
        self.height = lgDim 
        self.x = room.x + math.random(0, room.width - self.width)
        self.y = room.y + room.height
    elseif self.type == 'left' then
        self.opposite = 'right'
        self.width = lgDim
        self.height = smDim 
        self.x = room.x - self.width
        self.y = room.y + math.random(0, room.height - self.height)
    else
        self.opposite = 'left'
        self.width = lgDim
        self.height = smDim 
        self.x = room.x + room.width
        self.y = room.y + math.random(0, room.height - self.height)
    end

    -- guard to make sure a corridor isn't created outside of the map boundries
    -- use one tile of padding around the map
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
