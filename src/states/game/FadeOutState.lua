

FadeOutState = Class{__includes = BaseState}

function FadeOutState:init(color, time, callback)
    self.color = color
    self.opacity = self.color.a
    self.time = time
    self.callback = callback or function() end

    -- reset the master volume
    love.audio.setVolume(1)

    Timer.tween(self.time, {
        [self] = {opacity = 0}
    }):finish(function()
        gStateStack:pop()
        self.callback()
    end)
end

function FadeOutState:render()
    love.graphics.setColor(self.color.r, self.color.b, self.color.g, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255, 255)
end

