

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

                    Timer.tween(0.05, {
                        [self.activeChar] = {x = math.floor(self.activeChar.x + self.activeChar.width / 2)}
                    }):finish(function ()
                        Timer.tween(0.05, {
                            [self.activeChar] = {x = math.floor(self.activeChar.x - self.activeChar.width / 2)}
                        })
                    end)
                    --:finish(function ()
                        local dmg = self.activeChar.stats.str
                        self.enemies[i].currentHP = self.enemies[i].currentHP - dmg
                        self.damage:setNum(dmg, self.enemies[i].x + self.enemies[i].width / 2, 
                            self.enemies[i].y - gFonts['small']:getHeight())
                        --print(self.enemies[i].currentHP)

                        Timer.every(0.1, function()
                            self.enemies[i].opacity = self.enemies[i].opacity == 0 and 255 or 0
                        end):limit(6):finish(function()
                            gStateStack:pop()
                            gStateStack:pop()
                        end)   
                    --end)
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