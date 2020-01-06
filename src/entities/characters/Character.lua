--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Character --

    This class is used to instantiate a new character and contains all
    of the components that comprise a character.  A character is one 
    of the members that makes up the party that the player controls.

]]


Character = Class{}

function Character:init(def)
    self.name = def.name
    self.stats = Stats(def.stats)
    self.magic = Magic(def.magic)
    self.animations = def.anims

    -- keep track of position for battle actions
    -- these positions are only relevant in the battle state
    self.x = 0
    self.y = 0
    self.width = 16
    self.height = 18
    self.opacity = 255

    self.level = 1
    self.currentXP = 0
    self.XPToLevel = self:nextLevel(self.level)

    self.currentHP = self.stats.HP
    self.currentMP = self.stats.MP

    self.dead = false
end

-- level up the character and increase stats
function Character:levelUp()
    self.stats:levelUp()
    
    -- restore HP and MP when you level up
    self.currentHP = self.stats.HP
    self.currentMP = self.stats.MP

    self.level = self.level + 1
    self.XPToLevel = self:nextLevel(self.level)
end

-- add any new spells, call this when leveling up
function Character:newSpells()
    local newSpells = CHARACTER_MAGIC[self.name][self.level]
    if newSpells then
        for i = 1, #newSpells do
            self.magic:addSpell(newSpells[i])
        end
    end
    return newSpells
end


-- calculates the XP needed to reach the next level
function Character:nextLevel(level)
    local exponent = 1.5
    local baseXP = 1000
    return math.floor(baseXP * (level ^ exponent))
end

-- format the character stats into a string that can be used in a GUI element
function Character:printStats()
    local text =  'HP ' .. self.currentHP .. '/\n' .. self.stats:get('HP') .. '\n'
        .. 'MP ' .. self.currentMP .. '/\n' .. self.stats:get('MP') .. '\n\n'
        .. 'Str ' .. self.stats:get('str') .. '\n'
        .. 'Int ' .. self.stats:get('int') .. '\n'
        .. 'Spd ' .. self.stats:get('spd') .. '\n'
        .. 'Def ' .. self.stats:get('dfn') .. '\n'
    return text
end
