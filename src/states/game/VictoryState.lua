--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Victory State --

    This state is pushed when the player defeats the final boss, after a brief cutscene.  
    From here you return back to the start state and restart the game loop.
]]

VictoryState = Class{__includes = BaseState}

function VictoryState:init()
    love.audio.stop()
    gMusic['battle_victory']:play()
end

function VictoryState:update(dt) 

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('space') then
        gSfx['menu_select']:play()
        gStateStack:push(FadeInState(BLACK, 1, true, 
        function ()
            gMusic['battle_victory']:stop()
            gStateStack:pop()
            gStateStack:push(StartState())
            gStateStack:push(FadeOutState(BLACK, 1, false))
        end))  
    end
end

function VictoryState:render()
    love.graphics.clear(0, 0, 0, 255)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('The End', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end