--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- PlayerIdleState --

    This state inherits from the Entity Idle State with the difference
    being that this allows you to change state to walking if you press 
    one of the directionals keys.
]]


PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)
    if self.entity.canInput then
        if love.keyboard.isDown('up') then
            self.entity.direction = 'up'
            self.entity:changeState('walk')
        elseif love.keyboard.isDown('down') then
            self.entity.direction = 'down'
            self.entity:changeState('walk')
        elseif love.keyboard.isDown('left') then
            self.entity.direction = 'left'
            self.entity:changeState('walk')
        elseif love.keyboard.isDown('right') then
            self.entity.direction = 'right'
            self.entity:changeState('walk')
        end 
    end
end

