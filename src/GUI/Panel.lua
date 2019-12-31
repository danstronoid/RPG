--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Panel --

]]

Panel = Class{}

function Panel:init(x, y, width, height, color)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- create a color gradient
    self.mesh =  gradientMesh('vertical',
    {math.min(255, color.r * 2), 
    math.min(255, color.g * 2), 
    math.min(255, color.b * 2)},
    {color.r, color.g, color.b})

    self.visible = true
end

function Panel:render()
    if self.visible then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.mesh, self.x + LINE_WIDTH, self.y + LINE_WIDTH, 0, 
            self.width - LINE_WIDTH * 2, self.height - LINE_WIDTH * 2)
            
        love.graphics.setLineWidth(LINE_WIDTH)
        love.graphics.setLineStyle('rough')
        love.graphics.rectangle('line', self.x + (LINE_WIDTH / 2), self.y + (LINE_WIDTH / 2),
            self.width - (LINE_WIDTH / 2) * 2, self.height - (LINE_WIDTH / 2) * 2, 3)
    end
end

function Panel:toggle()
    self.visible = not self.visible
end