--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Camera --

]]

Camera = Class{}

function Camera:init(player)
    self.player = player

    self.x = 0
    self.y = 0
    self.offsetX = 0
    self.offsetY = 0
    self.startX = self.player.x 
    self.startY = self.player.y
    self.width = VIRTUAL_WIDTH
    self.height = VIRTUAL_HEIGHT
end

function Camera:update(dt)
    self.offsetX = self.startX - self.player.x
    self.offsetY = self.startY - self.player.y

    --print('(' .. self.offsetX .. ' ,' .. self.offsetY .. ')')
end

function Camera:reset()
    self.x = 0
    self.y = 0
    self.offsetX = 0
    self.offsetY = 0
    self.startX = self.player.x 
    self.startY = self.player.y
end
