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
    -- check collisions between entities
    for k, entity in pairs(self.level.entities) do
        if self.level.player:collides(entity) and love.keyboard.wasPressed('space') 
            and checkDirectionals() then
            entity:onInteract()
        end
    end

    --[[This is kind of a brute force way of stopping a bug where you continue to move
    if you hold down one of the arrow keys while opening the menu.  There is probably a better
    way to solve this, but this works for now.]] 
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') 
        and checkDirectionals() then
        -- there is a bug where you keep moving after entering this state
        gStateStack:push(FieldMenuState(self.startTime, self.level))
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

    -- draw lines to the screen for reference
    --love.graphics.line(VIRTUAL_WIDTH / 2, 0, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT)
    --love.graphics.line(0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, VIRTUAL_HEIGHT / 2)
end

-- test whether on of the directional keys is down, keeping the directionals down
-- while making other inputs causes problems
function checkDirectionals()
    return not (love.keyboard.isDown('up') or love.keyboard.isDown('down') 
        or love.keyboard.isDown('left') or love.keyboard.isDown('right'))
end