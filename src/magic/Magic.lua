--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Magic --
    
    This class is used to manage a table of all of the spells that a 
    player or entity can cast.
]]

Magic = Class{}

function Magic:init(def)
    self.spells = {}

    -- if given an initial definition of spells
    if def then
        for i = 1, #def do
            self:addSpell(def[i])
        end
    end
end

function Magic:addSpell(spell)
    if self.spells[spell] == nil then
        self.spells[spell] = MAGIC_DEFS[spell]
    end
end

function Magic:rmSpell(spell)
    if not self.spells[spell] == nil then
        self.spells[spell] = nil
    end
end

-- returns a random spell
function Magic:rndSpell()
    local list = {}
    for k, spell in pairs(self.spells) do
        table.insert(list, spell.name)
    end
    return self.spells[list[math.random(#list)]]
end

function Magic:printSpells()
    for k, spell in pairs(self.spells) do
        print(spell.name)
    end
end