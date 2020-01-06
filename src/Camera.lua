--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Camera --

]]

Camera = Class{}

function Camera:init()
    self.x = 0
    self.y = 0
    self.offsetX = 0
    self.offsetY = 0
    self.width = VIRTUAL_WIDTH
    self.height = VIRTUAL_HEIGHT
end

function Camera:update(dt) end

function Camera:reset()
    self.x = 0
    self.y = 0
    self.offsetX = 0
    self.offsetY = 0
end
