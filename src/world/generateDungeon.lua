--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Room --
]]
--Dungeon = class{}

function generateDungeon(mapWidth, mapHeight)

    local dungeon = TileMap(mapWidth, mapHeight)
    local maxRooms = 8
    local rooms = {}
    local corridors = {}

    -- create a map filled with empty tiles
    for y = 1, mapHeight do
        table.insert(dungeon.tiles, {})
        for x = 1, mapWidth do
            table.insert(dungeon.tiles[y], Tile(x, y, TILE_IDS['posts'], true))
        end
    end 

    -- fill the empty map with rooms
    for i = 1, maxRooms do
        if i == 1 then
            -- spawn the first room somewhere in the middle of the map
            rooms[i] = Room(mapWidth, mapHeight)
            corridors[i] = Corridor(mapWidth, mapHeight, rooms[i])
        elseif i == maxRooms then            
            rooms[i] = Room(mapWidth, mapHeight, corridors[i - 1])
            corridors[i] = Corridor(mapWidth, mapHeight, rooms[i])

            -- since this is the last room, set all the corridor flags to false
            -- so that it doesn't spawn
            for y = 1, mapHeight do
                for x = 1, mapWidth do
                    corridors[i].tiles[y][x] = false
                end
            end
        else
            rooms[i] = Room(mapWidth, mapHeight, corridors[i - 1])
            corridors[i] = Corridor(mapWidth, mapHeight, rooms[i])
        end

        -- use the room and corridor flags to change the tile ids in the dungeon TileMap
        for y = 1, mapHeight do
            for x = 1, mapWidth do
                if rooms[i].tiles[y][x] == true or corridors[i].tiles[y][x] then
                    dungeon.tiles[y][x].id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]
                    dungeon.tiles[y][x].solid = false
                end
            end
        end
    end

    return dungeon
end

