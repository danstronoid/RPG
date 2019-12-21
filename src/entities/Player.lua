

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)

    self.party = Party{
        members = {
            Character({
                name = 'Zappa',
                stats = CHARACTER_STATS['main'],
                anims = CHARACTER_ANIMS['main']
            })
        }
    }
end