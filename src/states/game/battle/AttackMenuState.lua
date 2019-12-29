

AttackMenuState = Class{__includes = BaseState}

function AttackMenuState:init(activeChar, enemies) 
    self.activeChar = activeChar
    self.enemies = enemies
    self.damage = Number()
    self.attacked = false

    local enemyList = {}
    for i = 1, #self.enemies do
        if not self.enemies[i].dead then
            local item = {
                text = self.enemies[i].name,
                onSelect = function() 
                    self.attacked = true

                    attack(self.activeChar, self.enemies[i], self.damage, function()
                        gStateStack:pop()
                        gStateStack:pop()
                    end)
                end
            }
        table.insert(enemyList, item)
        end
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
    if not self.attacked then
        self.attackMenu:update(dt)
    end
end

function AttackMenuState:render()
    if not self.attacked then
        self.attackMenu:render()
    end
    self.damage:render()
end