--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Dungeon --

    This class creates a randomly generated dungeon filled with rooms 
    and corridors.
]]
Dungeon = Class{}

function Dungeon:init(mapWidth, mapHeight, maxRooms)

    self.mapWidth = mapWidth
    self.mapHeight = mapHeight

    self.roooms = {}
    self.corridors = {}
    self:generateMap(maxRooms)

    self.floor = self:createFloor()
    self.walls = self:createWalls()
end

-- generates a dungeon map with a given number of rooms
function Dungeon:generateMap(maxRooms)
    local rooms = {}
    local corridors = {}

    -- fill the empty map with rooms
    for i = 1, maxRooms do
        if i == 1 then
            -- spawn the first room somewhere in the middle of the map
            rooms[i] = Room(self.mapWidth, self.mapHeight)
            corridors[i] = Corridor(self.mapWidth, self.mapHeight, rooms[i])
        elseif i == maxRooms then            
            rooms[i] = Room(self.mapWidth, self.mapHeight, corridors[i - 1])
            corridors[i] = Corridor(self.mapWidth, self.mapHeight, rooms[i])

            -- since this is the last room, set all the corridor flags to false
            -- so that it doesn't spawn
            for y = 1, self.mapHeight do
                for x = 1, self.mapWidth do
                    corridors[i].tiles[y][x] = false
                end
            end
        else
            rooms[i] = Room(self.mapWidth, self.mapHeight, corridors[i - 1])
            corridors[i] = Corridor(self.mapWidth, self.mapHeight, rooms[i])
        end
    end

    -- maintain a reference to all the rooms and corridors created
    self.rooms = rooms
    self.corridors = corridors
end

-- use the generated map of rooms and corridors to create a TileMap with floor tiles
function Dungeon:createFloor()
    local floor = TileMap(self.mapWidth, self.mapHeight)

    -- create a map filled with empty tiles
    for y = 1, self.mapHeight do
        table.insert(floor.tiles, {})
        for x = 1, self.mapWidth do
            table.insert(floor.tiles[y], Tile(x, y, TILE_IDS['empty'], true))
        end
    end 

    -- use the room and corridor flags to change the empty tiles to floor tiles
    for i = 1, #self.rooms do
        for y = 1, self.mapHeight do
            for x = 1, self.mapWidth do
                if self.rooms[i].tiles[y][x] == true or self.corridors[i].tiles[y][x] == true then
                    floor.tiles[y][x].id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]
                    floor.tiles[y][x].solid = false
                end
            end
        end
    end

    return floor
end

function Dungeon:createWalls()
    local walls = TileMap(self.mapWidth, self.mapHeight)

    -- create a map filled with empty tiles
    for y = 1, self.mapHeight do
        table.insert(walls.tiles, {})
        for x = 1, self.mapWidth do
            table.insert(walls.tiles[y], Tile(x, y, TILE_IDS['empty']))
        end
    end 

    -- use the room and corridor flags to change the empty tiles to wall tiles

    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            if self.floor.tiles[y][x].solid then
                if x > 1 and x < self.mapWidth and y > 1 and y < self.mapHeight then
                    -- create the edges
                    if not self.floor.tiles[y][x + 1].solid then
                        if not self.floor.tiles[y + 1][x].solid then
                            walls.tiles[y][x].id = TILE_IDS['top-left']
                            walls.tiles[y][x].solid = true
                        elseif not self.floor.tiles[y - 1][x].solid then
                            walls.tiles[y][x].id = TILE_IDS['bot-left']
                            walls.tiles[y][x].solid = true
                        else
                            walls.tiles[y][x].id = TILE_IDS['left-edge']
                            walls.tiles[y][x].solid = true
                        end
                    elseif not self.floor.tiles[y][x - 1].solid then
                        if not self.floor.tiles[y + 1][x].solid then
                            walls.tiles[y][x].id = TILE_IDS['top-right']
                            walls.tiles[y][x].solid = true
                        elseif not self.floor.tiles[y - 1][x].solid then
                            walls.tiles[y][x].id = TILE_IDS['bot-right']
                            walls.tiles[y][x].solid = true
                        else
                            walls.tiles[y][x].id = TILE_IDS['right-edge']
                            walls.tiles[y][x].solid = true
                        end
                    elseif not self.floor.tiles[y + 1][x].solid then
                        walls.tiles[y][x].id = TILE_IDS['top-edge']
                        walls.tiles[y][x].solid = true
                    elseif not self.floor.tiles[y - 1][x].solid then
                        walls.tiles[y][x].id = TILE_IDS['bot-edge']
                        walls.tiles[y][x].solid = true
                    end


                    -- add the corners
                    if self.floor.tiles[y][x + 1].solid and self.floor.tiles[y + 1][x].solid
                        and not self.floor.tiles[y + 1 ][x + 1].solid then
                            walls.tiles[y][x].id = TILE_IDS['top-left-corner']
                            walls.tiles[y][x].solid = true
                    elseif self.floor.tiles[y][x - 1].solid and self.floor.tiles[y + 1][x].solid
                    and not self.floor.tiles[y + 1 ][x - 1].solid then
                        walls.tiles[y][x].id = TILE_IDS['top-right-corner']
                        walls.tiles[y][x].solid = true
                    elseif self.floor.tiles[y][x + 1].solid and self.floor.tiles[y - 1][x].solid
                    and not self.floor.tiles[y - 1 ][x + 1].solid then
                        walls.tiles[y][x].id = TILE_IDS['bot-left-corner']
                        walls.tiles[y][x].solid = true
                    elseif self.floor.tiles[y][x - 1].solid and self.floor.tiles[y - 1][x].solid
                    and not self.floor.tiles[y - 1 ][x - 1].solid then
                        walls.tiles[y][x].id = TILE_IDS['bot-right-corner']
                        walls.tiles[y][x].solid = true
                    end
                end 

                -- if none of the conditions have been met, but the tile is solid
                if self.floor.tiles[y][x].solid and walls.tiles[y][x].id == TILE_IDS['empty'] then
                    walls.tiles[y][x].id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]
                    walls.tiles[y][x].solid = true
                end                
                
            end
        end
    end

    return walls
end