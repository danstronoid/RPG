--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Field Menu State --

    This state displays the field menu when opened in the field.  Currently,
    this menu only allows players to view items and stats.
]]

FieldMenuState = Class{__includes = BaseState}

function FieldMenuState:init(startTime, level)
    self.startTime = startTime
    self.level = level
    self.party = self.level.player.party

    self.fieldMenu = Menu {
        x = 3 * (VIRTUAL_WIDTH / 4),
        y = 0,
        width = VIRTUAL_WIDTH / 4,
        height = 3 * (VIRTUAL_HEIGHT / 4),
        color = GREY,
        cursor = true,
        justify = 'left',
        items = {
            {
                text = 'Items',
                onSelect = function()
                    gStateStack:push(ItemMenuState(self.level.player))
                end
            },
            {
                text = 'Magic',
                onSelect = function()
                end
            },
            {
                text = 'Stats',
                onSelect = function()
                    gStateStack:push(StatsMenuState(self.party))
                end
            },
            {
                text = 'Exit',
                onSelect = function()
                    gStateStack:pop()
                end
            }
        }
    }

    self.currentTime = math.floor(love.timer.getTime() - self.startTime)
    self.timeMenu =  Menu {
        x = 3 * (VIRTUAL_WIDTH / 4),
        y = 3 * (VIRTUAL_HEIGHT / 4),
        width = VIRTUAL_WIDTH / 4,
        height = VIRTUAL_HEIGHT / 4,
        color = GREY,
        --top = true,
        cursor = false,
        justify = 'left',
        items = {
            {
                text = formatTime(self.currentTime),
                onSelect = function() end
            },
            {
                text = self.level.player.gold .. ' G',
                onSelect = function() end
            } 
        }
    }

end

function FieldMenuState:enter()
    gSfx['menu_select']:play()
    self.level.player:changeState('idle')
end

function FieldMenuState:update(dt)
    -- keep updating the time
    self.currentTime = math.floor(love.timer.getTime() - self.startTime)
    self.timeMenu.selection.items[1].text = formatTime(self.currentTime)

    self.fieldMenu:update(dt)
    self.timeMenu:update(dt)
end

function FieldMenuState:render()
    self.fieldMenu:render()
    self.timeMenu:render()
end