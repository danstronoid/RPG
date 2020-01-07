

FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, time, callback)
    self.color = color
    self.opacity = 0
    self.time = time
    self.callback = callback or function() end
    self.volume = 1

    Timer.tween(self.time, {
        [self] = {opacity = self.color.a},
        [self] = {volume = 0}
    }):finish(function()
        gStateStack:pop()
        self.callback()
    end)
end

function FadeInState:render()
    -- fade out the master volume
    love.audio.setVolume(self.volume)

    love.graphics.setColor(self.color.r, self.color.b, self.color.g, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255, 255)
end