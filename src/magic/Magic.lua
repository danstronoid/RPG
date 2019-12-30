

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

function Magic:printSpells()
    for k, spell in pairs(self.spells) do
        print(spell.name)
    end
end