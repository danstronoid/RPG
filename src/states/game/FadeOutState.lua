

FadeOutState = Class{__includes = BaseState}

function FadeOutState:init(color, time, callback)
    self.color = color
    self.opacity = self.color.a
    self.time = time
    self.callback = callback or function() end
    self.volume = 0

    -- add a quick fade in to prevent pop
    Timer.tween(0.1, {
        [self] = {volume = 1}
    })

    Timer.tween(self.time, {
        [self] = {opacity = 0}
    }):finish(function()
        gStateStack:pop()
        self.callback()
    end)
end

function FadeOutState:update(dt)
    -- fade in the master volume
    love.audio.setVolume(self.volume)

end

function FadeOutState:render()
    love.graphics.setColor(self.color.r, self.color.b, self.color.g, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255, 255)
end

