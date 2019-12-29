--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- actions --

    This is a collections of functions that serve as an action a player can take during battle.

]]

ACTIONS = {
-- basic attack function, called in attack menu and enemy turn
['attack'] = 
    function(owner, target, Number, callback)
        local callback = callback or function() end

        Timer.tween(0.05, {
            [owner] = {x = math.floor(owner.x + owner.width / 2)}
        }):finish(function ()
            Timer.tween(0.05, {
                [owner] = {x = math.floor(owner.x - owner.width / 2)}
            }):finish(function ()
                local dmg = round(owner.stats.str * (MAX_DFN - target.stats.dfn) / MAX_DFN + 1)
                target.currentHP = target.currentHP - dmg
                Number:setNum(dmg, target.x + target.width / 2, 
                    target.y - gFonts['small']:getHeight())
        
                Timer.every(0.1, function()
                    target.opacity = target.opacity == 0 and 255 or 0
                end):limit(8):finish(function()
                    target.opacity = 255
                    callback()
                end)   
            end)
        end)  
    end,

['defend'] =
    function(owner, callback)

    end,

['item_restoreHP'] =
    function(item, owner, target, Number, callback)
        local callback = callback or function() end

        if target.currentHP > 0 then
            target.currentHP = math.min(target.stats.HP, target.currentHP + item.restore)
        end
        
        Number:setNum(item.restore, target.x + target.width / 2, 
            target.y - gFonts['small']:getHeight())

        Timer.every(0.1, function()
            target.opacity = target.opacity == 0 and 255 or 0
        end):limit(8):finish(function()
            target.opacity = 255
            callback()
        end)   
    end
}