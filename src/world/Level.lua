--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Level --
]]

Level = Class{}

function Level:init(camera)
    self.camera = camera

    self.tileMapWidth = 24
    self.tileMapHeight = 14

    --self.base = TileMap(self.tileMapWidth, self.tileMapHeight)
    --self.walls = TileMap(self.tileMapWidth, self.tileMapHeight)

    --self:createMap()
    self.base = generateDungeon(24, 24)

    self.player = Entity {
        mapX = (VIRTUAL_WIDTH / TILE_SIZE) / 2,
        mapY = (VIRTUAL_HEIGHT / TILE_SIZE + 0.5) / 2 ,
        width = 16,
        height = 16,
        animations = ENTITY_DEFS['player'].animations
    }

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }
    self.player.stateMachine:change('idle')

end

function Level:createMap()
    for y = 1, self.tileMapHeight do
        table.insert(self.base.tiles, {})

        for x = 1, self.tileMapWidth do
            local id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]

            table.insert(self.base.tiles[y], Tile(x, y, id))
        end
    end

    for y = 1, self.tileMapHeight do

        table.insert(self.walls.tiles, {})

        for x = 1, self.tileMapWidth do
            local id = TILE_IDS['posts']

            if y == 1 then
                table.insert(self.walls.tiles[y], Tile(x, y, id, true))
            elseif y > 1 and y < (self.tileMapHeight) and (x == 1 or x == self.tileMapWidth) then
                table.insert(self.walls.tiles[y], Tile(x, y, id, true))
            elseif y == self.tileMapHeight then
                table.insert(self.walls.tiles[y], Tile(x, y, id, true))
            else 
                table.insert(self.walls.tiles[y], Tile(x, y, TILE_IDS['empty'], false))
            end
            
        end
    end
end

function Level:update(dt) 
    self.player:update(dt)
end

function Level:render()
    self.base:render(self.camera)
    --self.walls:render(self.camera)
    self.player:render(self.camera)
end