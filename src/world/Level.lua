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

    self.mapWidth = 80
    self.mapHeight = 80

    self.dungeon = generateDungeon(self.mapWidth, self.mapHeight)

    self.player = Entity {
        mapX = self.mapWidth / 2 + 4,--(VIRTUAL_WIDTH / TILE_SIZE) / 2,
        mapY = self.mapHeight / 2 + 4,--(VIRTUAL_HEIGHT / TILE_SIZE + 0.5) / 2 ,
        width = 16,
        height = 16,
        animations = ENTITY_DEFS['player'].animations
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
end
