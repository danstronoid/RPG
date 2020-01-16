--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- StartState --
]]

StartState = Class{__includes = BaseState}

function StartState:init() 
    gMusic['intro']:setLooping(true)
    gMusic['intro']:play()

end

function StartState:update(dt) 

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') 
        or love.keyboard.wasPressed('space') then
        gSfx['menu_select']:play()
        gStateStack:push(FadeInState(BLACK, 1, 
        function ()
            gMusic['intro']:stop()
            gStateStack:pop()
            gStateStack:push(PlayState())
            gStateStack:push(FadeOutState(BLACK, 1,
            function ()
                gStateStack:push(DialogueState(""..
                "Help!  I'm trapped inside of a game.  Get me out of here!"))
            end))
        end))  
    end
end

function StartState:render()
    love.graphics.clear(0, 0, 0, 255)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('FINAL PROJECT', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')

    --love.graphics.setFont(gFonts['small'])
    
end