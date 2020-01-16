--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- NPC --

    This class inheritrs from the Entity class and is used to 
    create another entity that the player can interact with 
    in the field.
]]

NPC = Class{__includes = Entity}

function NPC:init(def)
    Entity.init(self, def)

    -- the flag pertains to entities in the field and not battle
    self.dead = false

    self.onInteract = def.onInteract or function() end
end

function NPC:onInteract()
    self.onInteract()
end
