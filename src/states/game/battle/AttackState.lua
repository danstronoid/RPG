--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Attack State --

    This state is pushed when the player chooses to attack from the 
    battle menu.  It pushes a target select state and then after a 
    target has been selected, it calls the attack action.
]]

AttackState = Class{__includes = BaseState}

function AttackState:init(activeChar, enemies) 
    self.activeChar = activeChar
    self.enemies = enemies
    self.damage = Number()
    self.attacked = false

    self.targetDef = {
        select = 'enemies',
        type = 'one'
    }
end

function AttackState:enter()
    gStateStack:push(TargetSelectState(_, self.enemies, self.targetDef, 
    function(target)
        ACTIONS['attack'](self.activeChar, target, self.damage, function()
            gStateStack:pop()
            gStateStack:pop()
        end)
    end))
end

function AttackState:render()
    self.damage:render()
end