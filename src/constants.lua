--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- constants --
]]
-- a multiplier for testing
VIRTUAL_ZOOM = 1
VIRTUAL_WIDTH = 384 * VIRTUAL_ZOOM
VIRTUAL_HEIGHT = 216 * VIRTUAL_ZOOM

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Tile constants
TILE_SIZE = 16
PADDING_TILE = 4

-- GUI constants
LINE_WIDTH = 2
BLACK = {r = 0, b = 0, g = 0, a = 255}
WHITE = {r = 255, b = 255, g = 255, a = 255}
GREY = {r = 56, g = 56, b = 56, a = 255}

-- keep track of time since starting the game
-- maybe move this to the playstate
START_TIME = love.timer.getTime()