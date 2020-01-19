--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Level --

    The level class creates a level with a dungeon and entities which the
    player can interact with.  At present this just creates a single level of a given size
    and initializes the player and all entities.  To make this reusable, it would be
    better to pass in the player and a table of entities.  Then you could use this to spawn a
    dungeon, town, or any other map.
]]

Level = Class{}

function Level:init(camera)
    self.camera = camera

    -- create a new dungeon
    self.maxRooms = 10 
    self.dungeon = Dungeon(120, 120, self.maxRooms)

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

    self.merchant = NPC {
        mapX = self.player.mapX,
        mapY =  self.player.mapY - 4,
        width = 16, 
        height = 18,
        animations = NPC_DEFS['Merchant'].animations,
        states = {['idle'] = function() return EntityIdleState(self.merchant) end},
        onInteract = function() 
            local inventory = {'Potion', 'Revive'}
            gStateStack:push(DialogueState('Looking for something?', function()
                gStateStack:push(ShopMenuState(self.player, inventory))
            end))
        end
    }
    self.merchant:changeState('idle')

    self.boss = NPC {
        -- spawn the player in the middle of the first room
        mapX = math.floor(self.dungeon.rooms[self.maxRooms].x + (self.dungeon.rooms[self.maxRooms].width / 2)),
        mapY =  math.floor(self.dungeon.rooms[self.maxRooms].y + (self.dungeon.rooms[self.maxRooms].height / 2)),
        width = 16,
        height = 18,
        animations = NPC_DEFS['Trolgus'].animations,
        states = {['idle'] = function() return EntityIdleState(self.boss) end},
        onInteract = function()
            self.player:changeState('idle')
            
            gStateStack:push(DialogueState('Graaaahh...', 
            function()
                gMusic['dungeon']:pause()
                gStateStack:push(BattleTransState(BLACK, 1, 
                function()
                    gStateStack:push(BossBattleState(self.player))
                end))
            end))
        end
    }
    self.boss:changeState('idle')

    -- keep a table of all entities in the level, this includes chests which do not belong to the entity class
    self.entities = {self.merchant, self.boss}

    -- random chance to spawn a chest in each room except the first or last
    for i = 2, (self.maxRooms - 1) do
        if math.random(6) == 1 then
            -- 50/50 chance to contain an item or gold
            if math.random(2) == 1 then    
                local contents = {'Potion', 'Revive'}
                table.insert(self.entities, Chest(
                    math.floor(self.dungeon.rooms[i].x + math.random(self.dungeon.rooms[i].width - 1)),
                    math.floor(self.dungeon.rooms[i].y + math.random(self.dungeon.rooms[i].height - 1)),
                    contents[math.random(#contents)]
                ))
            else
                table.insert(self.entities, Chest(
                    math.floor(self.dungeon.rooms[i].x + math.random(self.dungeon.rooms[i].width - 1)),
                    math.floor(self.dungeon.rooms[i].y + math.random(self.dungeon.rooms[i].height - 1)),
                    500, true))
            end
        end
    end

    -- set the camera position to the player's position
    self.camera:set(self.player.x + self.player.width / 2 - VIRTUAL_WIDTH / 2,
        self.player.y + self.player.height / 2 - VIRTUAL_HEIGHT / 2)
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
