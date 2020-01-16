--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Animation --

    This class is used to update and manage frame animations. 
    This was adopted from Colton Ogden's lecture in GD50.
]]

Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.texture = def.texture
    self.interval = def.interval
    self.loop = def.loop or true 

    self.timer = 0
    self.currentFrame = 1
    self.loopCount = 0
end

function Animation:update(dt)
    if not self.loop and self.loopCount > 0 then
        return
    end

    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))

            if self.currentFrame == 1 then
                self.loopCount = self.loopCount + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end

function Animation:refresh()
    self.timer = 0
    self.currentFrame = 1
    self.loopCount = 0
end
