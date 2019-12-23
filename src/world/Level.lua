--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Level --
]]

Level = Class{}

function Level:init(camera, dungeon)
    self.camera = camera

    self.dungeon = Dungeon(80, 80, 8)

    self.player = Player {
        -- spawn the player in the middle of the first room
        mapX = math.floor(self.dungeon.rooms[1].x + (self.dungeon.rooms[1].width / 2)),
        mapY =  math.floor(self.dungeon.rooms[1].y + (self.dungeon.rooms[1].height / 2)),
        width = 16,
        height = 18,
        animations = CHARACTER_ANIMS['zappa'].field
    }

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }
    self.player.stateMachine:change('idle')

    self.camera.offsetX = self.player.x - VIRTUAL_WIDTH / 2
    self.camera.offsetY = self.player.y - VIRTUAL_HEIGHT / 2
end

function Level:update(dt) 
    self.player:update(dt)
end

function Level:render()
    self.dungeon:render(self.camera)
    self.player:render(self.camera)
    love.graphics.draw(gTextures['octopus'], math.floor(self.dungeon.rooms[8].x + (self.dungeon.rooms[8].width / 2)) * TILE_SIZE, 
        math.floor(self.dungeon.rooms[8].y + (self.dungeon.rooms[8].height / 2)) * TILE_SIZE, 0, 1, 1, 
        math.floor(self.camera.offsetX), math.floor(self.camera.offsetY))
end
