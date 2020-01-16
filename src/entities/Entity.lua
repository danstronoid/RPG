--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Entity --

    This class instantiates an entity that exists in the field state.
    The player and NPC class inherit from entity and at present those are
    the only two type of entities you might encounter.
]]

Entity = Class{}

function Entity:init(def)
    self.mapX = def.mapX
    self.mapY = def.mapY
    self.width = def.width
    self.height = def.height
    self.x = (self.mapX - 1) * TILE_SIZE
    self.y = (self.mapY - 1) * TILE_SIZE - 4

    self.direction = 'down'
    self.animations = self:getAnimations(def.animations)
    self.currentAnimation = self.animations['idle-down']

    self.dead = false

    self.stateMachine = StateMachine(def.states)
    --self.stateMachine:change('idle')
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

-- AABB collision
function Entity:collides(other)
    return not (other.x > (self.x + self.width) or self.x > (other.x + other.width) or
        other.y > (self.y + self.height) or self.y > (other.y + other.height))
end