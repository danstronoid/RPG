BattleTransState = Class{__includes = BaseState}

function BattleTransState:init(color, time, callback)
    self.color = color
    self.rotation = 0
    self.scale = 0
    self.time = time
    self.callback = callback or function() end

    Timer.tween(self.time, {
        [self] = {scale = 1.5}
    }):finish(function()
        gStateStack:pop()
        self.callback()
    end)

    gMusic['battle_trans']:play()
end

function BattleTransState:update(dt)
    self.rotation = self.rotation + dt * math.pi * 2
end


function BattleTransState:render()
    love.graphics.setColor(self.color.r, self.color.b, self.color.g, self.color.a)
    love.graphics.translate(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)
    love.graphics.rotate(self.rotation)
    love.graphics.scale(self.scale)
    love.graphics.rectangle('fill', -VIRTUAL_WIDTH / 2, -VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.translate(-VIRTUAL_WIDTH / 2, -VIRTUAL_HEIGHT / 2)

    love.graphics.setColor(255, 255, 255, 255)
end