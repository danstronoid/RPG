

Enemy = Class{}

function Enemy:init(def)
    self.name = def.name
    self.stats = Stats(def.stats)
    self.texture = def.texture

    -- keep track of position for attack selection
    self.x = 0
    self.y = 0
    self.height = def.height
    self.width = def.width
    self.opacity = 255

    self.level = def.level
    self.XPDrop = def.XPDrop

    for i = 1, self.level do
        self.stats:levelUp()
    end

    --self.stats:debugPrint()

    self.currentHP = self.stats.HP

    self.dead = false
end

function Enemy:update(dt)

end

function Enemy:render()

end