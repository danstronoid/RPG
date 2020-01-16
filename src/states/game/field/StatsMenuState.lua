--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Stats Menu State --

    This state can be opened from the field menu and displays all 
    party member and their current stats.
]]

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
                    onSelect = function() end
                }
            }
        }
    end 
end

function StatsMenuState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') 
        or love.keyboard.wasPressed('space') then
        gStateStack:pop()
    end
    
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
