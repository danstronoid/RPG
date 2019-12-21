

FieldMenuState = Class{__includes = BaseState}

function FieldMenuState:init(startTime)
    self.startTime = startTime

    self.fieldMenu = Menu {
        x = 2 * (VIRTUAL_WIDTH / 3),
        y = 0,
        width = VIRTUAL_WIDTH / 3,
        height = 3 * (VIRTUAL_HEIGHT / 4),
        color = GREY,
        cursor = true,
        items = {
            {
                text = 'items',
                onSelect = function()
                end
            },
            {
                text = 'stats',
                onSelect = function()
                end
            },
            {
                text = 'exit',
                onSelect = function()
                    gStateStack:pop()
                end
            }
        }
    }

    self.currentTime = math.modf(love.timer.getTime() - self.startTime)
    self.timeMenu =  Menu {
        x = 2 * (VIRTUAL_WIDTH / 3),
        y = 3 * (VIRTUAL_HEIGHT / 4),
        width = VIRTUAL_WIDTH / 3,
        height = VIRTUAL_HEIGHT / 4,
        color = GREY,
        cursor = false,
        items = {
            {
                text = 'time ' .. formatTime(self.currentTime),
                onSelect = function() end
            },
            {
                text = 'coin 0',
                onSelect = function() end
            } 
        }
    }

end

function FieldMenuState:update(dt)
    self.fieldMenu:update(dt)
    self.timeMenu:update(dt)
end

function FieldMenuState:render()
    self.fieldMenu:render()
    self.timeMenu:render()
end