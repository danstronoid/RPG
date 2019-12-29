


BattleVictoryState = Class{__includes = BaseState}

function BattleVictoryState:init(player, enemies)
    self.player = player
    self.party = player.party
    self.enemies = enemies

    self.awardXP = self:calculateXP()
    self.awardGold = self:calculateGold()
    self.levelUp = ''

    for i = 1, #self.party.members do
        if not self.party.members[i].dead then
            self.party.members[i].currentXP = self.party.members[i].currentXP + self.awardXP
        end

        -- keep doing this incase more than one level is gained
        while self.party.members[i].currentXP >= self.party.members[i].XPToLevel do
            self.party.members[i].currentXP = self.party.members[i].currentXP % self.party.members[i].XPToLevel
            self.party.members[i]:levelUp()
            self.levelUp = self.levelUp .. self.party.members[i].name .. ' is now level ' .. self.party.members[i].level .. '!\n'
        end
    end

    self.player.gold = self.player.gold + self.awardGold
end

function BattleVictoryState:enter()
    gStateStack:push(BattleMessageState('You gained ' .. self.awardXP .. 'XP\n'
    .. 'You got ' .. self.awardGold .. 'G\n\n'
    .. self.levelUp,
    function()
    
        gStateStack:push(FadeInState(BLACK, 1, 
        function()
            -- pop off the battlestate
            gStateStack:pop()
            gStateStack:pop()
            gStateStack:push(FadeOutState(BLACK, 1))
        end))
    end))

end

function BattleVictoryState:calculateXP()
    local totalXP = 0
    for i = 1, #self.enemies do
        totalXP = totalXP + self.enemies[i].XPDrop
    end

    local totalMembers = 0
    for i =1, #self.party.members do
        if not self.party.members[i].dead then
            totalMembers = totalMembers + 1
        end
    end

    return math.floor(totalXP / totalMembers)
end

function BattleVictoryState:calculateGold()
    local gold = 0
    for i = 1, #self.enemies do
        gold = gold + self.enemies[i].goldDrop
    end
    return gold
end