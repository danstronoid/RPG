

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
    self.level.player:changeState('idle')
end

function FieldMenuState:update(dt)
    self.fieldMenu:update(dt)
    self.timeMenu:update(dt)
end

function FieldMenuState:render()
    self.fieldMenu:render()
    self.timeMenu:render()
end