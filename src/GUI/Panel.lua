--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Panel --

    Create a panel which is filled with a color gradient.
]]

Panel = Class{}

function Panel:init(x, y, width, height, color)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- create a color gradient
    self.mesh =  gradientMesh('vertical',
    {color.r, color.g, color.b},
    {math.max(0, color.r - 64), 
    math.max(0, color.g - 64), 
    math.max(0, color.b - 64)})

    self.visible = true
end

function Panel:render()
    if self.visible then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.mesh, self.x + LINE_WIDTH, self.y + LINE_WIDTH, 0, 
            self.width - LINE_WIDTH * 2, self.height - LINE_WIDTH * 2)
        
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setLineWidth(LINE_WIDTH)
        love.graphics.setLineStyle('smooth')
        love.graphics.rectangle('line', self.x + (LINE_WIDTH / 2), self.y + (LINE_WIDTH / 2),
            self.width - LINE_WIDTH, self.height - LINE_WIDTH, 3)
    end
end

function Panel:toggle()
    self.visible = not self.visible
end