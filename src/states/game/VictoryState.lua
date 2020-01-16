VictoryState = Class{__includes = BaseState}

function VictoryState:init()
    love.audio.stop()
    gMusic['battle_victory']:play()
end

function VictoryState:update(dt) 

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('space') then
        gSfx['menu_select']:play()
        gStateStack:push(FadeInState(BLACK, 1, 
        function ()
            gMusic['battle_victory']:stop()
            gStateStack:pop()
            gStateStack:push(StartState())
            gStateStack:push(FadeOutState(BLACK, 1))
        end))  
    end
end

function VictoryState:render()
    love.graphics.clear(0, 0, 0, 255)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Congratulations', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end