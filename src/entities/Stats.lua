

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
    self.dfnIv = def.dfnIv

    -- current stats
    self.HP = self.baseHP
    self.MP = self.baseMP
    self.str = self.baseStr
    self.int = self.baseInt
    self.spd = self.baseSpd
    self.dfn = self.baseDfn
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
function Stats:modify()

end

-- calculate how much to increase a stat based on its IV
function Stats:calculateIncrease(IV)
    local Increase = 0

    for i = 1, 3 do
        if math.random(6) <= IV then
            Increase = Increase + 1
        end
    end
    return Increase
end

