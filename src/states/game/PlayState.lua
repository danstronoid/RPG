--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- PlayState --

    This is the main play/field state that is pushed after you leave the start
    screen.  This state should remain on the stack until the player is defeated or
    the player defeats the final boss.
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camera = Camera()
    self.level = Level(self.camera)
    self.startTime = love.timer.getTime()

    gMusic['dungeon']:setLooping(true)
    gMusic['dungeon']:play()

    self.fps = 0

    self.endOfGame = false
    self.cutScene = false

    Event.on('endOfGame', function()
        self.endOfGame = true
    end)
end

function PlayState:enter()
    gStateStack:push(PartyDialogueState('Moon', self.level, 
        function(continue)
            Chain(
                function(go)
                    gStateStack:push(DialogueState("Zappa: How did we end up here?", go))
                end,
                function(go)
                    gStateStack:push(DialogueState("Zappa: We better have a look around.", go))
                end,
                function(go)
                    gStateStack:push(DialogueState("Moon: Alright big brother, but let's be careful.", go))
                end,
                function(go)
                    gStateStack:push(DialogueState("Moon: This place gives me the creeps.", go))
                end,
                function(go)
                    continue()
                end
            )()  
        end,
        function()
            Chain(
                function(go)
                    gStateStack:push(DialogueState("Press 'enter' to open the main menu.", go))
                end,
                function(go)
                    gStateStack:push(DialogueState("Press 'space' to talk to the merchant.", go))
                end
            )()  
        end
    ))
end

function PlayState:update(dt)
    -- short cut scene to play if you beat the boss, then the game starts over
    if self.endOfGame and not self.cutScene then
        self.cutScene = true
        gStateStack:push(DialogueState('...', 
        function()
            gSfx['death']:play()
            self.level.boss.dead = true
            Timer.after(2, function()
                gStateStack:push(FadeInState(BLACK, 1, function()
                    -- pop off the playstate
                    gStateStack:pop()
                    gStateStack:push(VictoryState())
                    gStateStack:push(FadeOutState(BLACK, 1))
                end))
            end)
        end))
    elseif not self.endOfGame then
        -- check collisions between entities
        for k, entity in pairs(self.level.entities) do
            if self.level.player:collides(entity) and love.keyboard.wasPressed('space') 
                and checkDirectionals() then
                entity:onInteract(self.level.player)
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
    end

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