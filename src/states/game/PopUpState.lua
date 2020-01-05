


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