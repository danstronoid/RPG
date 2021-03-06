--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- constants --
]]
-- a multiplier for testing
VIRTUAL_ZOOM = 1
VIRTUAL_WIDTH = 256 * VIRTUAL_ZOOM --384 
VIRTUAL_HEIGHT = 224 * VIRTUAL_ZOOM --216

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- set volume of sounds
MASTER_VOL = 1
MUSIC_VOL = 1
SFX_VOL = 0.6

-- the maximum for various stats
MAX_HP = 9999
MAX_DMG = 9999
MAX_DFN = 256

-- Tile constants
TILE_SIZE = 16
PADDING_TILE = 6

-- GUI constants
PADDING = 8 -- padding with respect to layout
LINE_WIDTH = 2
BLACK = {r = 0, b = 0, g = 0, a = 255}
WHITE = {r = 255, b = 255, g = 255, a = 255}
GREY = {r = 96, g = 96, b = 96, a = 255}

-- keep track of time since starting the game
START_TIME = 0