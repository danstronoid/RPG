--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Fade In State --

    This class is used to transition between states.  Transition is 
    2 parts, should be followed by Fade out
]]

FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, time, audioFade, callback)
    self.color = color
    self.opacity = 0
    self.time = time
    self.callback = callback or function() end

    -- if we want to fade the audio in this transition
    self.audioFade = audioFade
    self.volume = 1

    -- fade out the music
    Timer.tween(self.time, {
        [self] = {volume = 0}
    })

    Timer.tween(self.time, {
        [self] = {opacity = self.color.a},
    }):finish(function()
        gStateStack:pop()
        self.callback()
    end)
end

function FadeInState:update(dt)
    -- fade in the master volume
    if self.audioFade then
        love.audio.setVolume(self.volume)
    end

end

function FadeInState:render()
    love.graphics.setColor(self.color.r, self.color.b, self.color.g, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255, 255)
end