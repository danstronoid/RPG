

StatsMenuState = Class{__includes = BaseState}

function StatsMenuState:init(party)
    self.party = party
    self.charStats = {}

    self.panel = Panel(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, GREY)

    for i = 1, #self.party.members do
        local charText = self.party.members[i].name .. '\n'
        .. 'Lvl ' .. self.party.members[i].level .. '\n\n'
        .. 'XP ' .. self.party.members[i].currentXP .. '/ ' .. self.party.members[i].XPToLevel .. '\n\n'
        .. self.party.members[i]:printStats()

        self.charStats[i] = Menu {
            x = (i - 1) * (VIRTUAL_WIDTH / 4),
            y = 0,
            width = VIRTUAL_WIDTH / 4,
            height = VIRTUAL_HEIGHT,
            color = GREY,
            top = true,
            cursor = false,
            items = {
                {
                    text = charText,
                    onSelect = function()
                        gStateStack:pop()
                    end
                }
            }
        }
    end 
end

function StatsMenuState:update(dt)
    for i = 1, #self.charStats do
        self.charStats[i]:update(dt)
    end
end

function StatsMenuState:render()
    self.panel:render()
    for i = 1, #self.charStats do
        self.charStats[i]:render()
    end
end
