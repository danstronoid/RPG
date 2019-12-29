--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Enemy --

    This class is used to instantiate a new enemy and contains all
    of the components that comprise an enemy.  Enemies are created
    at random at the start of a battle.

]]

Enemy = Class{}

function Enemy:init(def)
    self.name = def.name
    self.stats = Stats(def.stats)
    self.texture = def.texture

    -- keep track of position for battle actions
    -- these positions are only relevant in the battle state
    self.x = 0
    self.y = 0
    self.height = def.height
    self.width = def.width
    self.opacity = 255

    self.level = def.level
    self.XPDrop = def.XPDrop
    self.goldDrop = def.goldDrop

    -- when an enemy is instantiated increase it's stats up to
    -- its defined level
    for i = 1, self.level do
        self.stats:levelUp()
    end

    self.currentHP = self.stats.HP

    self.dead = false
end

function Enemy:update(dt)

end

function Enemy:render()

end