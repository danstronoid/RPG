--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- StartState --

    This state is pushed when the game is first loaded and begin the game loop.
    The player is sent back here if they are defeated or if they defeat the final
    boss.  The title is drawn to a canvas and then stenciled over a generated
    dungeon.
]]

StartState = Class{__includes = BaseState}

function StartState:init() 
    self.camera = Camera()

    -- create a dungeon that looks fairly dense
    self.dungeon = Dungeon(60, 60, 30)

    -- start the camera's position in the middle of the dungeon
    self.camera:set(self.dungeon.rooms[1].x * TILE_SIZE, 
        self.dungeon.rooms[1].y * TILE_SIZE)
    
    -- flag to loop the camera movements
    self.looping = false

    gMusic['intro']:setLooping(true)
    gMusic['intro']:play()

    -- draw the title to canvas which renders it as a texture for stenciling
    love.graphics.setCanvas(gCanvas)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('ZAPPA QUEST 2', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setCanvas()

    -- slowly reveals title
    self.maskY = 0
    Timer.tween(6, {
        [self] = {maskY = VIRTUAL_HEIGHT}
    })

    -- blink the opacity of the 'press enter' text
    self.opacity = 255
    Timer.every(0.5, function()
        self.opacity = self.opacity == 0 and 255 or 0
    end)
end

-- clear the canvas on exit, so it can be reused
function StartState:exit()
    --love.graphics.setCanvas(gCanvas)
    --love.graphics.clear()
    --love.graphics.setCanvas()
end

function StartState:update(dt) 
    -- continuously move camera in a loop
    if not self.looping then
        self.looping = true
        Chain(
            function(go)
                self.camera:pan(2, 8 * TILE_SIZE, go)
            end,
            function(go)
                self.camera:tilt(2, 8 * TILE_SIZE, go)
            end,
            function(go)
                self.camera:pan(2, -8 * TILE_SIZE, go)
            end,
            function(go)
                self.camera:tilt(2, -8 * TILE_SIZE, go)
            end,
            function(go)
                self.looping = false
            end
        )()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') 
        or love.keyboard.wasPressed('space') then
        gSfx['menu_select']:play()
        gStateStack:push(FadeInState(BLACK, 1, true,
        function ()
            gMusic['intro']:stop()
            gStateStack:pop()
            gStateStack:push(PlayState())
            gStateStack:push(FadeOutState(BLACK, 1, false))
        end))  
    end
end

function StartState:render()
    love.graphics.clear(0, 0, 0, 255)
    
    -- basic shader that masks black pixels, taken from https://love2d.org/wiki/love.graphics.stencil
    local mask_shader = love.graphics.newShader[[
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
            if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
                // a discarded pixel wont be applied as the stencil.
                discard;
            }
            return vec4(1.0);
        }
    ]]

    local function textStencil()
        love.graphics.setShader(mask_shader)
        love.graphics.draw(gCanvas, 0, 0)
        love.graphics.setShader()
    end

    -- create a stencil for the title
    love.graphics.stencil(textStencil, 'replace', 1)

    love.graphics.setStencilTest('greater', 0)
    self.dungeon:render(self.camera)
    love.graphics.setStencilTest()

    --love.graphics.draw(canvas, 0, 0)

    -- this opacity blinks
    love.graphics.setColor(255, 255, 255, self.opacity)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')

    -- this rectangle slides down to reveal the text
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, self.maskY, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
end