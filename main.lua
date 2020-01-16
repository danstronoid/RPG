--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    A lot of the foundation for this game came from Assignment 7 - 50mon by Colton Ogden.
]]

require 'src/dependencies'

function love.load()
    love.window.setTitle('Final Project')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- set sound levels
    for k, music in pairs(gMusic) do 
        music:setVolume(MASTER_VOL * MUSIC_VOL)
    end 
    
    for k, sfx in pairs(gSfx) do 
        sfx:setVolume(MASTER_VOL * SFX_VOL)
    end

    -- set the start time
    START_TIME = love.timer.getTime()

    gStateStack = StateStack()
    gStateStack:push(StartState())

    -- keep a table of all keys pressed and clear it every update
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

-- function returns a boolean for a key pressed
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    Push:start()
    gStateStack:render()
    Push:finish()
end