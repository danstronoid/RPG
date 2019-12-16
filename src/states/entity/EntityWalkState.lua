--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- EntityWalkState --

]]

EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(entity, level)
    self.entity = entity
    self.level = level
end

function EntityWalkState:enter(params)
    self:move()
end

function EntityWalkState:move()
    local toX, toY = self.entity.mapX, self.entity.mapY

    if self.entity.direction == 'left' then
        toX = toX - 1
    elseif self.entity.direction == 'right' then
        toX = toX + 1
    elseif self.entity.direction == 'up' then
        toY = toY - 1
    else
        toY = toY + 1
    end

    -- if the tile is solid then don't move and return

    self.entity.mapX = toX
    self.entity.mapY = toY

    self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))

    Timer.tween(0.5, {
        [self.entity] = {x = (toX -1) * TILE_SIZE, y = (toY -1) * TILE_SIZE - self.entity.height / 2}
    }):finish(function ()
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
        else 
            self.entity:changeState('idle')
        end 
    end)
end