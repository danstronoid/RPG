--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- PlayState --
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camera = Camera()
    self.level = Level(self.camera)
    self.startTime = love.timer.getTime()

    self.fps = 0
end

function PlayState:update(dt)
    --[[This is kind of a brute force way of stopping a bug where you continue to move
    if you hold down one of the arrow keys while opening the menu.  There is probably a better
    way to solve this, but this works for now.]] 
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') 
        and not (love.keyboard.isDown('up') or love.keyboard.isDown('down') 
        or love.keyboard.isDown('left') or love.keyboard.isDown('right')) then
        -- there is a bug where you keep moving after entering this state
        gStateStack:push(FieldMenuState(self.startTime, self.level))

    -- heal the party, use this for debugging
    elseif love.keyboard.wasPressed('h') then
        for i = 1, #self.level.player.party.members do
            self.level.player.party.members[i].currentHP = self.level.player.party.members[i].stats.HP
            self.level.player.party.members[i].dead = false
            gStateStack:push(DialogueState('The party has been healed!'))
        end
    end

    self.level:update(dt)
    self.camera:update(dt)


    self.fps = love.timer.getFPS()
end

function PlayState:render()
    self.level:render()

    -- print the FPS
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(self.fps, 8, VIRTUAL_HEIGHT - 16, VIRTUAL_WIDTH,'left')
end