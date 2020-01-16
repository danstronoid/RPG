

DialogueState = Class{__includes = BaseState}

function DialogueState:init(text, callback)
    self.textbox = Textbox(0, 0, VIRTUAL_WIDTH, 64, text)
    self.callback = callback or function() end
end

function DialogueState:enter()
    --gSfx['menu_nav']:play()
end

function DialogueState:update(dt)
    self.textbox:update(dt)

    if self.textbox:isClosed() then
        gStateStack:pop()
        self.callback()
    end
end

function DialogueState:render()
    self.textbox:render()
end