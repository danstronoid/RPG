--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Player --

    The player class inherits from the entity class and contains the
    party and all of it's members.
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)

    -- keep track of steps between encounters
    self.steps = 0

    -- the player begins with two party members, more may be added later
    self.party = Party{
        members = {
            Character({
                name = 'Zappa',
                stats = CHARACTER_STATS['Zappa'],
                magic = CHARACTER_MAGIC['Zappa'][1],
                anims = CHARACTER_ANIMS['Zappa']
            }),
            Character({
                name = 'Tipper',
                stats = CHARACTER_STATS['Tipper'],
                magic = CHARACTER_MAGIC['Tipper'][1],
                anims = CHARACTER_ANIMS['Tipper']
            }),
        }
    }

    -- keep a table of all of the items in the player's inventory
    self.inventory = Inventory()

    -- start with 5 potions in your inventory
    self.inventory:addItem('Potion', 5)
    
    -- keep track of the player's gold
    self.gold = 0
end