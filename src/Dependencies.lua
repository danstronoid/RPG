--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Dependencies --
]]

-- libraries
Class = require 'lib/class'
Push = require 'lib/push'
Event = require 'lib/knife.event'
Timer = require 'lib/knife.timer'

-- misc
require 'src/constants'

-- state machine
require 'src/states/BaseState'
require 'src/states/StateStack'

-- game states
require 'src/states/game/StartState'

-- fonts
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}
