

-- this is a collections of functions that serve as an action a player can take during battle

function attack(attacker, defender, Number, callback)

local callback = callback or function() end

    Timer.tween(0.05, {
        [attacker] = {x = math.floor(attacker.x + attacker.width / 2)}
    }):finish(function ()
        Timer.tween(0.05, {
            [attacker] = {x = math.floor(attacker.x - attacker.width / 2)}
        }):finish(function ()
            local dmg = round(attacker.stats.str * (MAX_DFN - defender.stats.dfn) / MAX_DFN + 1)
            defender.currentHP = defender.currentHP - dmg
            Number:setNum(dmg, defender.x + defender.width / 2, 
                defender.y - gFonts['small']:getHeight())
    
            Timer.every(0.1, function()
                defender.opacity = defender.opacity == 0 and 255 or 0
            end):limit(8):finish(function()
                defender.opacity = 255
                callback()
            end)   
        end)
    end)  
end