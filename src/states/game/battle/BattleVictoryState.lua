


BattleVictoryState = Class{__includes = BaseState}

function BattleVictoryState:init(party, enemies)
    self.party = party
    self.enemies = enemies

    local awardXP = self:calculateXP()
    local partyList = {}


    for i = 1, #self.party.members do
        local leveled = false
        local memberText = self.party.members[i].name 

        if not self.party.members[i].dead then
            self.party.members[i].currentXP = self.party.members[i].currentXP + awardXP
            memberText = memberText .. ' + ' .. awardXP .. ' XP'
        end

        -- keep doing this incase more than one level is gained
        while self.party.members[i].currentXP >= self.party.members[i].XPToLevel do
            self.party.members[i].currentXP = self.party.members[i].currentXP % self.party.members[i].XPToLevel
            self.party.members[i]:levelUp()
            leveled = true   
        end

        if leveled then
            memberText = memberText .. ' Level up! '
        end

        memberText = memberText .. '\n' .. 'Lvl ' .. self.party.members[i].level .. '\n'
            .. 'XP to Lvl ' .. self.party.members[i].level + 1 .. ' '
            .. self.party.members[i].currentXP .. ' / ' .. self.party.members[i].XPToLevel .. '\n'

        local item = {
            text = memberText,
            onSelect = function() 
                -- pop off the victory state and the battle state
                gStateStack:pop()
                gStateStack:pop() 
            end
        }
        table.insert(partyList, item)
    end

    self.levelUpMenu = Menu {
        x = 0,
        y = 0,
        width = VIRTUAL_WIDTH,
        height = VIRTUAL_HEIGHT,
        color = GREY,
        cursor = false,
        items = partyList
    }
end

function BattleVictoryState:update(dt)
    self.levelUpMenu:update(dt)
end

function BattleVictoryState:render()
    self.levelUpMenu:render()
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