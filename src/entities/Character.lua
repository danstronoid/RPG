


Character = Class{__includes = Entity}

function Character:init(def)
    self.name = def.name
    self.stats = Stats(def.stats)
    self.animations = def.animations

    self.level = 1
    self.currentXP = 0
    self.XPToLevel = self:nextLevel(self.level)

    self.currentHP = self.stats.HP
    self.currentMP = self.stats.MP
end

-- level up the character and increase stats
function Character:levelUp()
    self.stats:levelUp()
    self.level = self.level + 1
    self.XPToLevel = self:nextLevel(self.level)
end

-- calculated the XP needed to reach the next level
function Character:nextLevel(level)
    local exponent = 1.5
    local baseXP = 1000
    return math.floor(baseXP * (level ^ exponent))
end