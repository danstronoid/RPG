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

end

function PlayState:update(dt)

    self.level:update(dt)
end

function PlayState:render()
    self.level:render()
end