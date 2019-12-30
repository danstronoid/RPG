--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Selection --
    
    This class creates a selection GUI which displays a list of items
    evenly spaced in a given height.  Selecting an item triggers its onSelect
    function.
]]

Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.font = def.font or gFonts['small']
    self.justify = def.justify or 'center'

    -- the maximum number of items to display per page
    self.maxItems = math.min(#self.items, math.floor((self.height - PADDING) / self.font:getHeight()))

    -- used to spread the items across the y-axis
    self.gapHeight = (self.height - PADDING) / self.maxItems

    -- use an offset to page up and down throught the items
    self.offset = 0

    -- flag for whether to center the items, or align to the top of the box
    -- by default items are centered
    self.top = def.top or false

    -- flag to display the cursor or not
    self.cursor = def.cursor
    self.currentSelection = 1
end

function Selection:update(dt)
    -- don't allow navigation up or down if there is no cursor
    if love.keyboard.wasPressed('up') and self.cursor then
        if self.currentSelection == 1 then
            -- wrap around to the last item
            self.currentSelection = #self.items
            self.offset = #self.items - self.maxItems 
        else
            self.currentSelection = self.currentSelection - 1
        end
    elseif love.keyboard.wasPressed('down') and self.cursor then
        if self.currentSelection == #self.items then
            -- wrap around to the first item
            self.currentSelection = 1
            self.offset = 0
        else
            self.currentSelection = self.currentSelection + 1
        end
    elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        self.items[self.currentSelection].onSelect()
    end

    if self.currentSelection > (self.maxItems + self.offset) then
        self.offset = self.offset + 1
    elseif self.currentSelection <= self.offset then
        self.offset = self.offset - 1
    end
end

function Selection:render()
    local currentY = self.y 

    for i = 1 + self.offset, self.maxItems + self.offset do
        -- calculate the Y for each item
        local paddedY = math.floor(currentY + (self.gapHeight / 2) - self.font:getHeight() / 2 + PADDING)

        -- if the items are aligned to the top then start there and move down by gapHeight
        if self.top then
            paddedY = math.floor(currentY + PADDING)
        end
        
        love.graphics.setFont(self.font)
        -- if the item is supposed to be highlighted then set the font to yellow
        if self.items[i].highlighted then
            love.graphics.setColor(255, 255, 0, 255)
        elseif self.items[i].greyed then
            love.graphics.setColor(128, 128, 128, 255)
        else
            love.graphics.setColor(255, 255, 255, 255)
        end

        love.graphics.printf(self.items[i].text, self.x + PADDING, paddedY, self.width - PADDING * 2, self.justify)

        -- reset the color
        love.graphics.setColor(255, 255, 255, 255)

        if i == self.currentSelection and self.cursor then
            love.graphics.draw(gTextures['cursor'], self.x - TILE_SIZE / 2, paddedY)
        end

        -- increment the current Y
        currentY = currentY + self.gapHeight
    end
end

-- toggle to hide the cursor
function Selection:toggleCursor()
    self.cursor = not self.cursor
end


