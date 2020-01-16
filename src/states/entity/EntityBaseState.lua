--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- EntityBaseState --

    This is the base state that serves as a template for all entity states.
    Each entity has it's own state machine which processes these states, 
    not the global state stack.
]]

EntityBaseState = Class{}

function EntityBaseState:init(entity)
    self.entity = entity 
end

function EntityBaseState:enter() end
function EntityBaseState:update(dt) end
-- functionEntityBaseState:processAI(params, dt) end
function EntityBaseState:exit() end

function EntityBaseState:render(camera)
    local animation = self.entity.currentAnimation
    --print('Texture ' .. animation.texture .. ' frame ' .. animation:getCurrentFrame())
    if not self.entity.dead then
        love.graphics.draw(gTextures[animation.texture], gFrames[animation.texture][animation:getCurrentFrame()],
            math.floor(self.entity.x), math.floor(self.entity.y),
            0, 1, 1, math.floor(camera.offsetX), math.floor(camera.offsetY))
    end
end