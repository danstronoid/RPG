


EnemyTurnState = Class{__includes = BaseState}

function EnemyTurnState:init(party, enemies, index)
    self.party = party
    self.enemies = enemies
    self.activeEnemy = self.enemies[index]

    self.damage = Number()
end


function EnemyTurnState:enter()

    gStateStack:push(BattleMessageState(self.activeEnemy.name .. ' attacks!',
    function()
        -- a random index of a party member
        local index = math.random(#self.party.members)

        while self.party.members[index].dead do
            index = math.random(#self.party.members)
        end

        ACTIONS['attack'](self.activeEnemy, self.party.members[index], self.damage, function()
            gStateStack:pop()
        end)
         
    end))
end

function EnemyTurnState:render()
    self.damage:render()
end