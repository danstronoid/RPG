

BossBattleState = Class{__includes = BattleState}

function BossBattleState:init(player)
    BattleState.init(self, player)

    self.enemies = {Enemy(BOSS_DEFS['Trolgus'])}
    self.enemies[1].boss = true

    self:setPositions()
end
