--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Dungeon --

    This class creates a randomly generated dungeon filled with rooms 
    and corridors. The dungeon has three layers of tile maps.  The first created
    is the floor which contains the general layout.  This is then filled with water
    which adds edges and corners.  The last is a layer of walls which boxes the entire map
    in a rectangle.  The generate map function is responsible for the randomized generation.
]]
Dungeon = Class{}

function Dungeon:init(mapWidth, mapHeight, maxRooms)

    self.mapWidth = mapWidth
    self.mapHeight = mapHeight

    self.roooms = {}
    self.corridors = {}
    self:generateMap(maxRooms)

    self.floor = self:createFloor()
    self.water = self:createWater()
    self.walls = self:createWalls()
    self:addDetails()
end

function Dungeon:render(camera)
    self.floor:render(camera)
    self.water:render(camera)
    self.walls:render(camera)
end

-- generates a dungeon map with a given number of rooms, the map is a table of booleans
function Dungeon:generateMap(maxRooms)
    local rooms = {}
    local corridors = {}

    -- fill the empty map with rooms
    for i = 1, maxRooms do
        -- spawn the first room somewhere in the middle of the map
        if i == 1 then
            rooms[i] = Room(self.mapWidth, self.mapHeight)
            corridors[i] = Corridor(self.mapWidth, self.mapHeight, rooms[i])

        -- spawn the last room
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
        
        -- spawn all other rooms
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
                    changeTileID(floor, x, y, 'ground', false, math.random(#TILE_IDS['ground']))
                end
            end
        end
    end

    -- fill in any stretches of wall that are only 1 tile in width or height
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            -- make sure to index inside of the bound of the array
            if x > 1 and x < self.mapWidth and y > 1 and y < self.mapHeight then
                if floor.tiles[y][x].solid and not floor.tiles[y - 1][x].solid
                    and not floor.tiles[y + 1][x].solid then
                        changeTileID(floor, x, y, 'ground', false, math.random(#TILE_IDS['ground']))
                elseif floor.tiles[y][x].solid and not floor.tiles[y][x - 1].solid
                    and not floor.tiles[y][x + 1].solid then
                        changeTileID(floor, x, y, 'ground', false, math.random(#TILE_IDS['ground']))
                end
            end
        end
    end

    return floor
end

function Dungeon:createWater()
    local water = TileMap(self.mapWidth, self.mapHeight)

    -- create a map filled with empty tiles
    for y = 1, self.mapHeight do
        table.insert(water.tiles, {})
        for x = 1, self.mapWidth do
            table.insert(water.tiles[y], Tile(x, y, TILE_IDS['empty']))
        end
    end 

    -- use the room and corridor flags to change the empty tiles to water tiles

    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            if self.floor.tiles[y][x].solid then
                -- make sure to index inside of the bound of the array
                if x > 1 and x < self.mapWidth and y > 1 and y < self.mapHeight then
                    -- create the edges
                    if not self.floor.tiles[y][x + 1].solid then
                        if not self.floor.tiles[y + 1][x].solid then
                            changeTileID(water, x, y, 'water-top-left', true)
                        elseif not self.floor.tiles[y - 1][x].solid then
                            changeTileID(water, x, y, 'water-bot-left', true)
                        else
                            changeTileID(water, x, y, 'water-left-edge', true)
                        end
                    elseif not self.floor.tiles[y][x - 1].solid then
                        if not self.floor.tiles[y + 1][x].solid then
                            changeTileID(water, x, y, 'water-top-right', true)
                        elseif not self.floor.tiles[y - 1][x].solid then
                            changeTileID(water, x, y, 'water-bot-right', true)
                        else
                            changeTileID(water, x, y, 'water-right-edge', true)
                        end
                    elseif not self.floor.tiles[y + 1][x].solid then
                        changeTileID(water, x, y, 'water-top-edge', true)
                    elseif not self.floor.tiles[y - 1][x].solid then
                        changeTileID(water, x, y, 'water-bot-edge', true)
                    end


                    -- add the corners
                    if self.floor.tiles[y][x + 1].solid and self.floor.tiles[y + 1][x].solid
                        and not self.floor.tiles[y + 1 ][x + 1].solid then
                            changeTileID(water, x, y, 'water-top-left-corner', true)
                    elseif self.floor.tiles[y][x - 1].solid and self.floor.tiles[y + 1][x].solid
                        and not self.floor.tiles[y + 1 ][x - 1].solid then
                            changeTileID(water, x, y, 'water-top-right-corner', true)
                    elseif self.floor.tiles[y][x + 1].solid and self.floor.tiles[y - 1][x].solid
                        and not self.floor.tiles[y - 1 ][x + 1].solid then
                            changeTileID(water, x, y, 'water-bot-left-corner', true)
                    elseif self.floor.tiles[y][x - 1].solid and self.floor.tiles[y - 1][x].solid
                        and not self.floor.tiles[y - 1 ][x - 1].solid then
                            changeTileID(water, x, y, 'water-bot-right-corner', true)
                    end
                end 

                -- if none of the conditions have been met, but the tile is solid
                if self.floor.tiles[y][x].solid and water.tiles[y][x].id == TILE_IDS['empty'] then
                    changeTileID(water, x, y, 'water', true)
                end              
                
            end
        end
    end

    return water
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

    local leftEdge = self.mapWidth
    local rightEdge = 0
    local topEdge = self.mapHeight
    local botEdge = 0

    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            if not self.floor.tiles[y][x].solid then
                if x < leftEdge then
                    leftEdge = x - 1
                elseif x >= rightEdge then
                    rightEdge = x + 1
                end

                if y < topEdge then
                    topEdge = y - 1
                elseif y >= botEdge then
                    botEdge = y + 1
                end
            end
        end
    end

    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            -- add the edges
            if x == leftEdge and y > topEdge and y < botEdge then
                if self.water.tiles[y][x].id == TILE_IDS['water'] then
                    changeTileID(walls, x, y, 'wall-left-edge-w', true, 'y')
                else
                    changeTileID(walls, x, y, 'wall-left-edge', true, 'y')
                end
            elseif x == rightEdge and y > topEdge and y < botEdge then
                if self.water.tiles[y][x].id == TILE_IDS['water'] then
                    changeTileID(walls, x, y, 'wall-right-edge-w', true, 'y')
                else
                    changeTileID(walls, x, y, 'wall-right-edge', true, 'y')
                end
            elseif y == topEdge and x > leftEdge and x < rightEdge then
                self:topEdgeSpawn(walls, x, y)
            elseif y == botEdge and x > leftEdge and x < rightEdge then
                changeTileID(walls, x, y, 'wall-bot-edge', true, 'x')
            end

            -- add the corners
            if y == botEdge and x == leftEdge then
                changeTileID(walls, x, y, 'wall-bot-left-corner', true)
            elseif y == botEdge and x == rightEdge then
                changeTileID(walls, x, y, 'wall-bot-right-corner', true)
            elseif y == topEdge and x == leftEdge then
                self:topLeftCorner(walls, x, y)
            elseif y == topEdge and x == rightEdge then
                self:topRightCorner(walls, x, y)
            end

            -- fill in the rest
            if x < leftEdge or y < topEdge or x > rightEdge or y > botEdge then
                changeTileID(walls, x, y, 'dark', true)
            end
        end
    end

    --print(leftEdge .. ', ' .. rightEdge ..', ' .. topEdge .. ', ' .. botEdge)

    return walls
end

-- create the pattern for the top edge
function Dungeon:topEdgeSpawn(walls, x, y)
    for i = 1, 4 do
        changeTileID(walls, x, y - i, 'wall-top-edge-' .. i, true, 'x')
    end
end

-- create the pattern for the top left corner
function Dungeon:topLeftCorner(walls, x, y)
    for i = y, y - 3, -1 do
        changeTileID(walls, x, i, 'wall-left-edge', true, 'y')
    end

    if self.water.tiles[y][x].id == TILE_IDS['water'] then
        changeTileID(walls, x, y, 'wall-left-edge-w', true, 'y')
    end

    if self.water.tiles[y - 1][x].id == TILE_IDS['water'] then
        changeTileID(walls, x, y - 1, 'wall-left-edge-w', true, 'y')
    end

    changeTileID(walls, x, y - 4, 'wall-top-left-corner', true)
end

-- create the pattern for the top right corner
function Dungeon:topRightCorner(walls, x, y)
    for i = y, y - 3, -1 do
        changeTileID(walls, x, i, 'wall-right-edge', true, 'y')
    end
    if self.water.tiles[y][x].id == TILE_IDS['water'] then
        changeTileID(walls, x, y, 'wall-right-edge-w', true, 'y')
    end
    changeTileID(walls, x, y - 4, 'wall-top-right-corner', true)
end

function Dungeon:addDetails()
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            if not self.floor.tiles[y][x].solid then 
                if math.random(64) == 1 then
                    changeTileID(self.floor, x, y, 'rocks', false, math.random(#TILE_IDS['rocks']))
                elseif math.random(64) == 1 then
                    changeTileID(self.floor, x, y, 'cracks', false)
                elseif math.random(256) == 1 then
                    changeTileID(self.floor, x, y, 'hole', true)
                    self.water.tiles[y][x].solid = true
                end
            end
        end
    end
end

-- change the id of a tile, the alt parameter is used to alternate tiles on 
-- the x or y axis. Alt can also be a numerical index of a particular tile id.
function changeTileID(tileMap, x, y, id, solid, alt)
    if alt == 'y' then
        tileMap.tiles[y][x].id = TILE_IDS[id][y % 2 + 1]
    elseif alt == 'x' then
        tileMap.tiles[y][x].id = TILE_IDS[id][x % 2 + 1]
    elseif alt == nil then
        tileMap.tiles[y][x].id = TILE_IDS[id]
    else
        tileMap.tiles[y][x].id = TILE_IDS[id][alt]
    end
        
    tileMap.tiles[y][x].solid = solid
end