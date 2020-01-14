

NPC = Class{__includes = Entity}

function NPC:init(def)
    Entity.init(self, def)

    self.onInteract = def.onInteract or function() end
end

function NPC:onInteract()
    self.onInteract()
end
