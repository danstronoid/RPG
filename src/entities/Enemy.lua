

Enemy = Class{}

function Enemy:init(def)
    self.name = def.name
    self.stats = Stats(def.stats)
    self.texture = def.texture
    self.height = def.height
    self.width = def.width

    self.level = def.level
    self.XPDrop = def.XPDrop

    for i = 1, self.level do
        self.stats:levelUp()
    end

    --self.stats:debugPrint()

end

function Enemy:update(dt)

end

function Enemy:render()

end