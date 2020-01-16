--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Battle Item State --

    This state is pushed when the player chooses to use an item from the 
    battle menu.  After an item has been selected, it pushes a target select state 
    and then the appropriate item action is called on that target.
]]

BattleItemState = Class{__includes = BaseState}

function BattleItemState:init(player, activeChar, enemies)
    self.player = player
    self.inventory = player.inventory 
    self.party = player.party
    self.activeChar = activeChar
    self.enemies = enemies
    self.number = Number()
    self.itemUsed = false

    local itemList = {}
    for k, item in pairs(self.inventory.items) do
        table.insert(itemList, {
            text = item.def.name .. ' : ' .. item.noHeld,
            onSelect = function() 
                self.itemMenu.selection:toggleCursor()
                gStateStack:push(TargetSelectState(self.party, self.enemies, item.def.target,
                function(target)
                    self.itemUsed = true
                    ACTIONS[item.def.action](item.def, self.activeChar, target, self.number,
                    function()
                        self.inventory:rmItem(k, 1)
                        -- pop off the item state and the menu state
                        gStateStack:pop()
                        gStateStack:pop()
                    end)
                end))
            end
        })
    end
    
    table.insert(itemList, {
        text = 'Cancel',
        onSelect = function()
            gStateStack:pop()
        end
    })

    self.itemMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = true,
        justify = 'left',
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