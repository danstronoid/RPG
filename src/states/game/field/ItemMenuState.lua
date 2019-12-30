

ItemMenuState = Class{__includes = BaseState}

function ItemMenuState:init(player)
    self.player = player
    self.inventory = player.inventory

    local itemList = {}
    for k, item in pairs(self.inventory.items) do
        table.insert(itemList, {
            text = item.def.name .. ' : ' .. item.noHeld,
            onSelect = function()
                gStateStack:push(DialogueState(item.def.text, function()
                    gStateStack:pop()
                end)) 
            end
        })
    end

    self.itemMenu = Menu{
        x = VIRTUAL_WIDTH / 2,
        y = 0,
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT,
        color = GREY,
        top = true,
        cursor = true,
        items = itemList
    }
end

function ItemMenuState:update(dt)
    self.itemMenu:update(dt)
end

function ItemMenuState:render()
    self.itemMenu:render()
end