

AttackMenuState = Class{__includes = BaseState}

function AttackMenuState:init(activeChar, enemies) 
    self.activeChar = activeChar
    self.enemies = enemies

    local enemyList = {}
    for i = 1, #self.enemies do
        local item = {
            text = self.enemies[i].name,
            onSelect = function() end
        }
        table.insert(enemyList, item)
    end

    local cancel = {
        text = 'Cancel',
        onSelect = function()
            gStateStack:pop()
        end
    }
    table.insert(enemyList, cancel)

    self.attackMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = true,
        items = enemyList
    }
end

function AttackMenuState:update(dt)
    self.attackMenu:update(dt)
end

function AttackMenuState:render()
    self.attackMenu:render()
end