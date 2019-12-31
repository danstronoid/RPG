--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Stats --

    The class contains all stats and belongs to the character and 
    enemy classes.  The stats class also does calculations for leveling up
    and modifying stats in battle.
]]

Stats = Class{}

function Stats:init(def, level)
    -- base stats
    self.baseHP = def.baseHP -- HP
    self.baseMP = def.baseMP -- MP
    self.baseStr = def.baseStr -- Strength
    self.baseInt = def.baseInt -- Intelligence
    self.baseSpd = def.baseSpd -- Speed
    self.baseDfn = def.baseDfn -- Defense
    -- luck
    -- sanity

    -- chance of stat increase
    self.HPIV = def.HPIV
    self.MPIV = def.MPIV
    self.strIV = def.strIV
    self.intIV = def.intIV
    self.spdIV = def.spdIV
    self.dfnIV = def.dfnIV

    -- current stats
    self.HP = self.baseHP
    self.MP = self.baseMP
    self.str = self.baseStr
    self.int = self.baseInt
    self.spd = self.baseSpd
    self.dfn = self.baseDfn

    -- table of active modifiers
    --[[in the format self.modifiers[name] = {
        add = {[stat] = value}, 
        mult = {[stat] = value}
    } ]]
    self.modifiers = {}
end

-- increase stats on level up
function Stats:levelUp()
    -- HP and MP should increase at a faster rate
    self.HP = self.HP + self:calculateIncrease(self.HPIV)
    self.MP = self.MP + self:calculateIncrease(self.MPIV)

    self.str = self.str + self:calculateIncrease(self.strIV)
    self.int = self.int + self:calculateIncrease(self.intIV)
    self.spd = self.spd + self:calculateIncrease(self.spdIV)
    self.dfn = self.dfn + self:calculateIncrease(self.dfnIV)
end

-- temporarily modify a stat during battle
function Stats:addMod(name, mod)
    if self.modifiers[name] == nil then
        self.modifiers[name] = {
            add = mod.add or {},
            mult = mod.mult or {}
        }
    end
end

-- remove a modifier
function Stats:rmMod(name)
    self.modifiers[name] = nil
end

-- remove all modifiers
function Stats:clearMods()
    self.modifiers = {}
end

-- returns a given modified stat
function Stats:get(stat)
    local add = 0
    local mult = 0

    for k, mod in pairs(self.modifiers) do
        add = add + (mod.add[stat] or 0)
        mult = mult + (mod.mult[stat] or 0)
    end

    if stat == 'HP' then
        return (self.HP + add) + (self.HP * mult)
    elseif stat == 'MP' then
        return (self.MP + add) + (self.MP * mult)
    elseif stat == 'str' then
        return (self.str + add) + (self.str * mult)
    elseif stat == 'int' then
        return (self.int + add) + (self.int * mult)
    elseif stat == 'spd' then
        return (self.spd + add) + (self.spd * mult)
    elseif stat == 'dfn' then
        return (self.dfn + add) + (self.dfn * mult)
    else 
        print('invalid stat')
        return
    end
end

-- calculate how much to increase a stat based on its IV
function Stats:calculateIncrease(IV)
    local increase = 0

    for i = 1, 3 do
        if math.random(6) <= IV then
            increase = increase + 1
        end
    end
    return increase
end

-- debug function for stats
function Stats:debugPrint()
    print('baseHP ' .. self.baseHP .. '\n'
        .. 'baseMP ' .. self.baseMP .. '\n'
        .. 'baseStr ' .. self.baseStr .. '\n'
        .. 'baseInt ' .. self.baseInt .. '\n'
        .. 'baseSpd ' .. self.baseSpd .. '\n'
        .. 'baseDfn ' .. self.baseDfn .. '\n'
    
        ..'HPIV ' .. self.HPIV .. '\n'
        .. 'MPIV ' .. self.MPIV .. '\n'
        .. 'strIV ' .. self.strIV .. '\n'
        .. 'intIV ' .. self.intIV .. '\n'
        .. 'spdIV ' .. self.spdIV .. '\n'
        .. 'dfnIV ' .. self.dfnIV .. '\n'

        ..'HP ' .. self.HP .. '\n'
        .. 'MP ' .. self.MP .. '\n'
        .. 'str ' .. self.str .. '\n'
        .. 'int ' .. self.int .. '\n'
        .. 'spd ' .. self.spd .. '\n'
        .. 'dfn ' .. self.dfn .. '\n'
    )
end
    

