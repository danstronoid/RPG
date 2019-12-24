


EnemyTurnState = Class{__includes = BaseState}

function EnemyTurnState:init(party, enemies, index)
    self.party = party
    self.enemies = enemies
    self.activeEnemy = self.enemies[index]

end


function EnemyTurnState:enter()
    gStateStack:pop()
end

