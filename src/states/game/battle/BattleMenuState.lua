

BattleMenuState = Class{__includes = BaseState}


function BattleMenuState:init(party, enemies, index)

    self.party = party
    self.enemies = enemies
    self.activeChar = self.party.members[index]

    local statuses = {}

    for i = 1, #self.party.members do
        if not self.party.members[i].dead then
            local item = {
                text = self.party.members[i].name,
                highlighted = false,
                onSelect = function () end
            }
                if i == index then
                item.highlighted = true
            end
            table.insert(statuses, item)
        end   
    end

    self.partyStatus = Menu {
        x = 0,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = false,
        items = statuses
    }

    self.battleMenu = Menu {
        x = 3 * VIRTUAL_WIDTH / 4,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 4,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = true,
        items = {
            {
                text = 'Attack',
                onSelect = function()
                    gStateStack:push(AttackMenuState(self.activeChar, self.enemies))
                end
            },
            {
                text = 'Defend',
                onSelect = function()
                    gStateStack:pop()
                end
            },
            {
                text = 'Item',
                onSelect = function()
                end
            },
            {
                text = 'Run',
                onSelect = function()
                    gStateStack:push(FadeInState(BLACK, 1,
                    function()
                        -- pop off the battle menu, the turn state, and the battle state
                        gStateStack:pop()
                        gStateStack:pop()
                        gStateStack:pop()
                        gStateStack:push(FadeOutState(BLACK, 1))
                    end))
                end
            }
        }
    }
end

function BattleMenuState:update(dt)
    self.battleMenu:update(dt)
end

function BattleMenuState:render()
    self.partyStatus:render()
    self.battleMenu:render()
end
