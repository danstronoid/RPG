--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Entity --

]]

Entity = Class{}

function Entity:init(def)
    self.mapX = def.mapX
    self.mapY = def.mapY
    self.width = def.width
    self.height = def.height
    self.x = (self.mapX - 1) * TILE_SIZE
    self.y = (self.mapY - 1) * TILE_SIZE - self.height / 2

    self.direction = 'down'
    self.animations = self:getAnimations(def.animations)
    self.currentAnimation = self.animations['idle-down']
end

function Entity:update(dt)
    self.currentAnimation:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render(camera)
    self.stateMachine:render(camera)
end

function Entity:getAnimations(animationDefs)
    local animationsReturned = {}

    for k, animationDef in pairs(animationDefs) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end
    return animationsReturned
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end