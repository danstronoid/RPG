--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- EntityBaseState --

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
    love.graphics.draw(gTextures[animation.texture], gFrames[animation.texture][animation:getCurrentFrame()],
        math.floor(self.entity.x), math.floor(self.entity.y))
end