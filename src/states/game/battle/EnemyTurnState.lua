


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

        Timer.tween(0.05, {
            [self.activeEnemy] = {x = math.floor(self.activeEnemy.x + self.activeEnemy.width / 2)}
        }):finish(function ()
            Timer.tween(0.05, {
                [self.activeEnemy] = {x = math.floor(self.activeEnemy.x - self.activeEnemy.width / 2)}
            })
        end)
        --:finish(function ()
            local dmg = self.activeEnemy.stats.str
            self.party.members[index].currentHP = self.party.members[index].currentHP - dmg
            self.damage:setNum(dmg, self.party.members[index].x + self.party.members[index].width / 2, 
                self.party.members[index].y - gFonts['small']:getHeight())
    
            Timer.every(0.1, function()
                self.party.members[index].opacity = self.party.members[index].opacity == 0 and 255 or 0
            end):limit(6):finish(function()
                self.party.members[index].opacity = 255
                gStateStack:pop()
            end)   
    end))
end

function EnemyTurnState:render()
    self.damage:render()
end