--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Camera --

    This class creates a camera object which keeps track
    of an offset that is used in all calls to love.draw.
]]

Camera = Class{}

function Camera:init()
    self.offsetX = 0
    self.offsetY = 0
    self.width = VIRTUAL_WIDTH
    self.height = VIRTUAL_HEIGHT
end

function Camera:update(dt) end

function Camera:reset()
    self.offsetX = 0
    self.offsetY = 0
end

function Camera:set(x, y)
    self.offsetX = x
    self.offsetY = y
end

function Camera:pan(duration, amount, callback)
    local callback = callback or function() end
    Timer.tween(duration, {
        [self] = {offsetX = self.offsetX + amount}
    }):finish(function() callback() end)
end

function Camera:tilt(duration, amount, callback)
    local callback = callback or function() end
    Timer.tween(duration, {
        [self] = {offsetY = self.offsetY + amount}
    }):finish(function() callback() end)
end