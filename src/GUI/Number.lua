--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Display Number --

    Display a number on the screen.  This is useful for showing
    damage or healing above a sprite.
]]

Number = Class{}

function Number:init(num, x, y)
    self.num = num or 0
    self.x = x or 0
    self.y = y or 0

    self.visible = false
end

function Number:render()
    if self.visible then
        love.graphics.setFont(gFonts['small'])
        -- add a drop shadow
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.print(self.num, self.x + 1, self.y + 1)
        
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.print(self.num, self.x, self.y)
    end
end

function Number:setNum(num, x, y)
    self.num = num
    self.x = x
    self.y = y

    self.visible = true
end

function Number:toggle()
    self.visible = not self.visible
end