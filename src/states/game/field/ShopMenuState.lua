

ShopMenuState = Class{__includes = BaseState}

function ShopMenuState:init(player, shopInventory)
    self.player = player
    self.shopInventory = shopInventory

    local shopList = {}
    for i, item in pairs(shopInventory) do
        table.insert(shopList, {
            text = item .. ' ' .. ITEM_DEFS[item].price .. ' G',
            onSelect = function()
                if self.player.gold >= ITEM_DEFS[item].price then
                    self.player.inventory:addItem(item, 1)
                    self.player.gold = self.player.gold - ITEM_DEFS[item].price
                else
                    gStateStack:push(DialogueState('You seem to be short on funds.'))
                end
            end
        })
    end

    table.insert(shopList, {
        text = 'Done',
        onSelect = function()
            gStateStack:push(DialogueState('Thank you! Come back if you need any supplies.', 
            function()
                gStateStack:pop()
            end))
        end
    })

    self.shopMenu = Menu{
        x = 0,
        y = 0,
        width = VIRTUAL_WIDTH / 2,
        height = 64,
        color = GREY,
        top = true,
        cursor = true,
        justify = 'left',
        items = shopList
    }

    self.infoMenu = Menu{
        x = VIRTUAL_WIDTH / 2,
        y = 0,
        width = VIRTUAL_WIDTH / 2,
        height = 64,
        color = GREY,
        top = false,
        cursor = false,
        justify = 'left',
        items = {
            {
                text = self.player.gold .. ' G',
                onSelect = function() end
            }
        }
    }

end

function ShopMenuState:update(dt)
    self.infoMenu.selection.items[1].text = self.player.gold .. ' G'
    self.shopMenu:update(dt)
    self.infoMenu:update(dt)
end

function ShopMenuState:render()
    self.shopMenu:render()
    self.infoMenu:render()
end