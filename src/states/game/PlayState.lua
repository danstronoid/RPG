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
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- there is a bug where you keep moving after entering this state
        gStateStack:push(FieldMenuState(self.startTime, self.level))
    end

    -- heal the party, use this for debugging
    if love.keyboard.wasPressed('h') then
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