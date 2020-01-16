--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- EntityIdleState --

    This state is used when an entity is idle.
]]

EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('idle-' .. self.entity.direction)
end