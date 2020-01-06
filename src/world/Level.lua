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

    -- create a new dungeon
    self.dungeon = Dungeon(100, 100, 10)

    -- initialize the player
    self.player = Player {
        -- spawn the player in the middle of the first room
        mapX = math.floor(self.dungeon.rooms[1].x + (self.dungeon.rooms[1].width / 2)),
        mapY =  math.floor(self.dungeon.rooms[1].y + (self.dungeon.rooms[1].height / 2)),
        width = 16,
        height = 18,
        animations = CHARACTER_ANIMS['Zappa'].field,
        states = {
            ['walk'] = function() return PlayerWalkState(self.player, self) end,
            ['idle'] = function() return PlayerIdleState(self.player) end
        }
    }
    self.player:changeState('idle')

    self.boss = NPC {
        -- spawn the player in the middle of the first room
        mapX = math.floor(self.dungeon.rooms[2].x + (self.dungeon.rooms[2].width / 2)),
        mapY =  math.floor(self.dungeon.rooms[2].y + (self.dungeon.rooms[2].height / 2)),
        width = 16,
        height = 18,
        animations = NPC_DEFS['Trolgus'].animations,
        states = {['idle'] = function() return EntityIdleState(self.boss) end},
        onInteract = function()
            self.player:changeState('idle')
            
            gStateStack:push(DialogueState('I am error.', 
            function()
                gStateStack:push(BattleTransState(BLACK, 1, 
                function()
                    gStateStack:push(BossBattleState(self.player))
                end))
            end))
        end
    }

    -- keep a table of all entities in the level
    self.entities = {self.boss}

    for k, entity in pairs(self.entities) do
        entity:changeState('idle')
    end

    -- set the camera position to the player's position
    self.camera.offsetX = self.player.x + self.player.width / 2 - VIRTUAL_WIDTH / 2
    self.camera.offsetY = self.player.y + self.player.height / 2 - VIRTUAL_HEIGHT / 2
end

function Level:update(dt) 
    self.player:update(dt)
    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function Level:render()
    self.dungeon:render(self.camera)
    for k, entity in pairs(self.entities) do
        entity:render(self.camera)
    end
    self.player:render(self.camera)
end
