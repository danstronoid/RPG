

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.steps = 0

    self.party = Party{
        members = {
            Character({
                name = 'Zappa',
                stats = CHARACTER_STATS['zappa'],
                anims = CHARACTER_ANIMS['zappa']
            }),
            Character({
                name = 'Tipper',
                stats = CHARACTER_STATS['tipper'],
                anims = CHARACTER_ANIMS['tipper']
            }),
        }
    }
end