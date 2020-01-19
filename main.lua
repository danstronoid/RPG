--[[
    Zappa Quest 2
    GD50 Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    Zappa Quest 2 is a SNES-era style turn based RPG.  The player controls the main character Zappa
    as they explore a procedurally generated dungeon and fight monsters along the way.  The game
    ends if the player defeats the final boss or the player meets their demise at the hand of 
    a monster.

    The foundation was built from the concepts in GD50 Assignment 7 by Colton Ogden.

    All music by Daniel Schwartz

    Sound design created using Bfxr

    Character textures by Anifarea https://opengameart.org/content/antifareas-rpg-sprite-set-1-enlarged-w-transparent-background

    Enemy textures by RedShrike https://opengameart.org/content/more-rpg-enemies

    Cave tileset by MrBeast https://opengameart.org/content/cave-tileset-0 

    Item textures from https://opengameart.org/content/16x16-rpg-items
]]

require 'src/dependencies'

function love.load()
    love.window.setTitle('Final Project')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        vsync = true,
        resizable = true
    })

    -- global canvas which can be used for rendering
    gCanvas = love.graphics.newCanvas(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    -- set volume for SFX and music
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