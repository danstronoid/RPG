

Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.font = def.font or gFonts['small']
    self.gapHeight = (self.height - PADDING) / #self.items

    self.cursor = def.cursor
    self.currentSelection = 1
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') and self.cursor then
        if self.currentSelection == 1 then
            -- wrap around to the last item
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
        end

    elseif love.keyboard.wasPressed('down') and self.cursor then
        if self.currentSelection == #self.items then
            -- wrap around to the first item
            self.currentSelection = 1
        else
            self.currentSelection = self.currentSelection + 1
        end
    elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        self.items[self.currentSelection].onSelect()
    end
end

function Selection:render()
    local currentY = self.y 

    for i = 1, #self.items do
        local paddedY = math.floor(currentY + (self.gapHeight / 2) - self.font:getHeight() / 2 + PADDING)

        if i == self.currentSelection and self.cursor then
            love.graphics.draw(gTextures['cursor'], self.x - TILE_SIZE / 2, paddedY)
        end
        
        love.graphics.setFont(self.font)
        if self.items[i].highlighted then
            love.graphics.setColor(255, 255, 0, 255)
        else
            love.graphics.setColor(255, 255, 255, 255)
        end

        love.graphics.printf(self.items[i].text, self.x + TILE_SIZE / 2, paddedY, self.width, 'left')
    
        currentY = currentY + self.gapHeight
    end
end


