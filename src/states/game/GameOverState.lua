
GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    love.audio.stop()
    gMusic['gameover']:play()
end

function GameOverState:update(dt) 

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')
        or love.keyboard.wasPressed('space') then
        gSfx['menu_select']:play()
        gStateStack:push(FadeInState(BLACK, 1, 
        function ()
            gMusic['gameover']:stop()
            gStateStack:pop()
            gStateStack:push(StartState())
            gStateStack:push(FadeOutState(BLACK, 1))
        end))  
    end
end

function GameOverState:render()
    love.graphics.clear(0, 0, 0, 255)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end