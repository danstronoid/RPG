

Inventory = Class{}

function Inventory:init()
    self.items = {}
end

function Inventory:addItem(item, num)
    if self.items[item] == nil then
        self.items[item] = {def = ITEM_DEFS[item], noHeld = num}
    else
        self.items[item].noHeld = self.items[item].noHeld + num
    end
end

function Inventory:rmItem(item, num)
    self.items[item].noHeld = self.items[item].noHeld - num
    if self.items[item].noHeld <= 0 then
        self.items[item] = nil
    end
end

-- print the inventory for debugging
function Inventory:printInventory()
    for k, item in pairs(self.items) do
        print(k, item.noHeld)
    end
end

-- in order to implement this need to copy inventory into array 
-- and then will need to add a get inventory method
function Inventory:sort()
    local sortedInventory = {}

    for k, item in pairs(self.items) do
        table.insert(sortedInventory, k)
    end

    table.sort(sortedInventory)
    --table.foreachi(sortedInventory, print)

    return sortedInventory
end