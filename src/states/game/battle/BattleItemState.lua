



BattleItemState = Class{__includes = BaseState}

function BattleItemState:init(player, activeChar, enemies)

    self.inventory = player.inventory 
    self.party = player.party
    self.activeChar = activeChar
    self.enemies = enemies
    self.number = Number()
    self.itemUsed = false

    local itemList = {}
    for i = 1, #self.inventory do
        local item = {
            text = self.inventory[i].item.name .. ' : ' .. self.inventory[i].noHeld,
            onSelect = function() 
                self.itemMenu.selection:toggleCursor()
                gStateStack:push(TargetSelectState(self.party, self.enemies, self.inventory[i].item.target,
                function(target)
                    self.itemUsed = true
                    ACTIONS[self.inventory[i].item.action](self.inventory[i].item, self.activeChar, target, self.number,
                    function()
                        self.inventory[i].noHeld = self.inventory[i].noHeld - 1
                        if self.inventory[i].noHeld == 0 then
                            table.remove(self.inventory, i)
                        end
                        -- pop off the item state and the menu state
                        gStateStack:pop()
                        gStateStack:pop()
                    end)
                end))
            end
        }
        table.insert(itemList, item)
    end

    local cancel = {
        text = 'Cancel',
        onSelect = function()
            gStateStack:pop()
        end
    }
    table.insert(itemList, cancel)

    self.itemMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = true,
        items = itemList
    }
end

function BattleItemState:update(dt)
    if not self.itemUsed then
        self.itemMenu:update(dt)
    end
end

function BattleItemState:render()
    if not self.itemUsed then
        self.itemMenu:render()
    end
    self.number:render()
end