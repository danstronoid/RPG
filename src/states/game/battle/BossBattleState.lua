

BossBattleState = Class{__includes = BattleState}

function BossBattleState:init(player)
    BattleState.init(self, player)

    self.enemies = {Enemy(BOSS_DEFS['Trolgus'])}
    
    self:setPositions()
end

function BossBattleState:exit()
    Event.dispatch('endOfGame')
end
