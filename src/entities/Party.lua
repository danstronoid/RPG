--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Party --

    This party class is a container class for all of the 
    characters that belong to it.
]]

Party = Class{}

function Party:init(def)
    -- this is a table of Character or Enemy objects
    self.members = def.members or {}
end

-- implement these in the future
function Party:addMember() end

function Party:rmMember() end