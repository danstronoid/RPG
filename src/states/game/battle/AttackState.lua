

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