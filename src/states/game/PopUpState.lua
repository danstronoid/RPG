--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Pop Up State --

    This state is used for displaying a pop up message for a given
    duration in seconds.  Primarily used in battle to display spell
    names when cast.
]]


PopUpState = Class{__includes = BaseState}

function PopUpState:init(text, dur, onClose)
    self.popUp = PopUp(text)
    self.onClose = onClose or function() end
    self.dur = dur
end

function PopUpState:enter()
    Timer.after(self.dur, function()
        gStateStack:pop()
        self.onClose()
    end)
end

function PopUpState:render()
    self.popUp:render()
end