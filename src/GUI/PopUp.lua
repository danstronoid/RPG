--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Pop Up --

    Display a small text box that's size varies on the
    text which it displays. This is used when casting spells
    to display the spell name.
]]

PopUp = Class{}

function PopUp:init(text)
    self.text = text
    self.font = gFonts['small']

    self.width = 8 * #self.text + PADDING
    self.height = TILE_SIZE + PADDING
    self.x = (VIRTUAL_WIDTH - self.width) / 2
    self.y = TILE_SIZE

    self.panel = Panel(self.x, self.y, self.width, self.height, GREY)

    self.closed = false
end

function PopUp:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') 
        or love.keyboard.wasPressed('space') then
        self.closed = true
    end
end

function PopUp:render()
    self.panel:render()

    local yPos = self.y + PADDING

    love.graphics.setFont(self.font)

    -- add drop shadow
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf(self.text, self.x + 1, yPos + 1, self.width, 'center')

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(self.text, self.x, yPos, self.width, 'center')
end

function PopUp:isClosed()
    return self.closed
end