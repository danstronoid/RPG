--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- PlayState --
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = Level()

    self.camera = Camera(self.level.player)
end

function PlayState:update(dt)
    self.level:update(dt)
    self.camera:update(dt)
end

function PlayState:render()
    self.level:render(self.camera)
end