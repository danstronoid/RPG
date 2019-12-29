--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Menu --

    This class is used to create a menu.  A menu is comprised of 
    a panel and a selection.

]]


Menu = Class{}

function Menu:init(def)
    self.panel = Panel(def.x, def.y, def.width, def.height, def.color)

    self.selection = Selection {
        items = def.items,
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height,
        top = def.top,
        cursor = def.cursor
    }
end

function Menu:update(dt)
    self.selection:update(dt)
end

function Menu:render()
    self.panel:render()
    self.selection:render()
end