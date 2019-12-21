

StatsMenuState = Class{__includes = BaseState}

function StatsMenuState:init(party)
    self.party = party

    self.panel = Panel(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, GREY)
    self.text = {}
    self.charStats = {}

    for i = 1, #self.party.members do
        local text = self.party.members[i].name .. '\n \n'
        .. 'Lvl ' .. self.party.members[i].level .. '\n'
        .. 'HP ' .. self.party.members[i].stats.HP .. '\n'
        .. 'MP ' .. self.party.members[i].stats.MP .. '\n'
        .. 'Str ' .. self.party.members[i].stats.str .. '\n'
        .. 'Int ' .. self.party.members[i].stats.int .. '\n'
        .. 'Spd ' .. self.party.members[i].stats.spd .. '\n'
        .. 'Def ' .. self.party.members[i].stats.dfn .. '\n'
        table.insert(self.text, text)

        self.charStats[i] = Menu {
            x = (i - 1) * (VIRTUAL_WIDTH / 4),
            y = 0,
            width = VIRTUAL_WIDTH / 4,
            height = VIRTUAL_HEIGHT,
            color = GREY,
            cursor = false,
            items = {
                {
                    text = self.text[i],
                    onSelect = function()
                        gStateStack:pop()
                    end
                },
                {
                    text = '',
                    onSelect = function() end
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
