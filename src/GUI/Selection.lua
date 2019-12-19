

Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.font = def.font or gFonts['small']
    self.gapHeight = self.height / #self.items

    self.cursor = def.cursor
    self.currentSelection = 1
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') then
        if self.currentSelection == 1 then
            -- wrap around to the last item
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
        end

    elseif love.keyboard.wasPressed('down') then
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

end


