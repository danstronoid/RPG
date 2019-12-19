--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- PlayState --
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camera = Camera()
    self.level = Level(self.camera)

    self.fps = 0
end

function PlayState:update(dt)
    self.level:update(dt)
    self.camera:update(dt)

    self.fps = love.timer.getFPS()
end

function PlayState:render()
    self.level:render()

    -- print the FPS
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(self.fps, 8, VIRTUAL_HEIGHT - 16, VIRTUAL_WIDTH,'left')
end