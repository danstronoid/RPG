


EnemyTurnState = Class{__includes = BaseState}

function EnemyTurnState:init(party, enemies, index)
    self.party = party
    self.enemies = enemies
    self.activeEnemy = self.enemies[index]

    self.damage = Number()
end


function EnemyTurnState:enter()
    local spell = self.activeEnemy.magic:rndSpell()

    -- if the enemy has any spells, else do a normal attack
    if spell and math.random(2) == 1 then
        gStateStack:push(BattleMessageState(self.activeEnemy.name .. ' casts ' .. spell.name .. '!',
        function()
            if self.activeEnemy.currentMP < spell.mp_cost then
                gStateStack:push(BattleMessageState('... but ' .. self.activeEnemy.name .. ' is out of MP!',
                function()
                    gStateStack:pop()
                end))
            else
                local target = self:target(spell.target)
                gStateStack:push(PopUpState(spell.name, 1,
                function()
                    ACTIONS[spell.action](spell, self.activeEnemy, target, self.damage, 
                    function()
                        gStateStack:pop()
                    end)
                end))
            end
        end))
    else
        gStateStack:push(BattleMessageState(self.activeEnemy.name .. ' attacks!',
        function()
            local target = self:target({select = 'enemies', type = 'one'})
            ACTIONS['attack'](self.activeEnemy, target, self.damage, function()
                gStateStack:pop()
            end)
        end))
    end
         
end

function EnemyTurnState:render()
    self.damage:render()
end

-- in this function it's worth noting that the enemies and party members switch roles as
-- the enemy of the enemies is the party members, so it gets a bit confusing
function EnemyTurnState:target(def)
    local target

    if def.select == 'enemies' then
        if def.type == 'all' then
            -- return a table of all living party members
            target = {}
            for k, member in pairs(self.party.members) do
                if not member.dead then
                    table.insert(target, member)
                end
            end
        else
            -- a random index of a party member
            repeat
                target = self.party.members[math.random(#self.party.members)]
                -- make sure the target isn't already dead
            until(not target.dead)
        end
    elseif def.select == 'party' then
        if def.type == 'all' then
            -- return a table of all living enemies
            target = {}
            for k, enemy in pairs(self.enemies) do
                if not enemy.dead then
                    table.insert(target, enemy)
                end
            end
        else
            repeat
                target = self.enemies[math.random(#self.enemies)]
                -- make sure the target isn't already dead
            until(not target.dead)
        end
    end

    return target
end