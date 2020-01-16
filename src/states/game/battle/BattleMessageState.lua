--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Battle Message State --

    This state displays a message during battle.
]]

BattleMessageState = Class{__includes = BaseState}

function BattleMessageState:init(text, onClose, canInput)
    self.textbox = Textbox(0, 2 * VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, VIRTUAL_HEIGHT / 3, text)

    self.onClose = onClose or function() end

    self.canInput = canInput

    if self.canInput == nil then 
        self.canInput = true 
    end
end

function BattleMessageState:update(dt)
    if self.canInput then
        self.textbox:update(dt)

        if self.textbox:isClosed() then
            gStateStack:pop()
            self.onClose()
        end
    end
end

function BattleMessageState:render()
    self.textbox:render()
end