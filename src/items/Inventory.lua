--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Inventory --
    
    This class is used to manage a table of all of the player's items.
    Need to implement a way to sort this at some point.
    This also could be used to manage items belonging to NPCs, possibly
    to limit the quantities of items that merchants have.
]]

Inventory = Class{}

function Inventory:init()
    self.items = {}
end

-- add an item to the player's inventory
function Inventory:addItem(item, num)
    if self.items[item] == nil then
        self.items[item] = {def = ITEM_DEFS[item], noHeld = num}
    else
        self.items[item].noHeld = self.items[item].noHeld + num
    end
end

-- remove an item from the player's inventory
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