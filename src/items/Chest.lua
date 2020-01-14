

Chest = Class{}

function Chest:init(mapX, mapY, contents, gold) 
    self.mapX = mapX
    self.mapY = mapY
    self.width = 16
    self.height = 16
    self.x = (self.mapX - 1) * TILE_SIZE
    self.y = (self.mapY - 1) * TILE_SIZE - 4

    self.frame = 54
    self.opened = false
    self.contents = contents
    self.gold = gold or false
end

function Chest:update(dt)

end

function Chest:render(camera)
    love.graphics.draw(gTextures['items'], gFrames['items'][self.frame],
        math.floor(self.x), math.floor(self.y), 0, 1, 1, 
        math.floor(camera.offsetX), math.floor(camera.offsetY))
end

function Chest:onInteract(player)
    if not self.opened then
        if self.gold then
            gStateStack:push(DialogueState('You found '.. self.contents .. 'G!',
            function()
                player.gold = player.gold + self.contents
                self.frame = 55
                self.opened = true
            end))
        else
            gStateStack:push(DialogueState('You found a '.. self.contents .. '!',
            function()
                player.inventory:addItem(self.contents, 1)
                self.frame = 55
                self.opened = true
            end))
        end
    end
end