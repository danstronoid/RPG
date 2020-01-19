--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- character magic --

    This table keeps track of all of the spells each character
    starts with and which spells should be given to the player 
    at each level.

]]


CHARACTER_MAGIC = {
    ['Zappa'] = {
        [1] = {'Heal'},
        [2] = {'Protect'}
    },
    ['Moon'] = {
        [1] = {'Fire'},
        [3] = {'Ice'}
    }
}