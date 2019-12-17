


function generateDungeon(width, height)

    local dungeon = TileMap(width, height)
    local room = createRoom()

    --dungeon = room

    for y = 1, room.height do
        table.insert(dungeon.tiles, {})

        for x = 1, room.width do
            table.insert(dungeon.tiles[y], Tile(x, y, 46))
        end
    end

    return dungeon
end

function createRoom()
    local roomWidth = math.random(5, 10)
    local roomHeight = math.random(5, 10)
    local room = TileMap(roomWidth, roomHeight)

    for y = 1, roomHeight do
        table.insert(room.tiles, {})

        for x = 1, roomWidth do
            local id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]

            table.insert(room.tiles[y], Tile(x, y, id))
            --print(room.tiles[y][x].id)
        end
    end

    return room
end