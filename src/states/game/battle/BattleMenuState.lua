

BattleMenuState = Class{__includes = BaseState}


function BattleMenuState:init(party, enemies)

    self.party = party
    self.enemies = enemies

    self.battleMenu = Menu {
        x = 3 * (VIRTUAL_WIDTH / 4),
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 4,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = true,
        items = {
            {
                text = 'attack',
                onSelect = function()
                end
            },
            {
                text = 'defend',
                onSelect = function()
                end
            },
            {
                text = 'item',
                onSelect = function()
                end
            },
            {
                text = 'run',
                onSelect = function()
                    gStateStack:push(FadeInState(BLACK, 1,
                    function()
                        -- pop off the battle menu and the battle state
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
    self.battleMenu:render()
end
