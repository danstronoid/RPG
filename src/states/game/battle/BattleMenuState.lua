

BattleMenuState = Class{__includes = BaseState}


function BattleMenuState:init(player, enemies, index)
    self.player = player
    self.party = player.party
    self.enemies = enemies
    self.activeChar = self.party.members[index]

    local statuses = {}

    for i = 1, #self.party.members do
        if not self.party.members[i].dead then
            local item = {
                text = self.party.members[i].name .. ' '
                    .. self.party.members[i].currentHP .. '/' 
                    .. self.party.members[i].stats.HP,
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
        x = VIRTUAL_WIDTH / 2,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = true,
        items = {
            {
                text = 'Attack',
                onSelect = function()
                    self.battleMenu.selection:toggleCursor()
                    gStateStack:push(AttackState(self.activeChar, self.enemies))
                end
            },
            {
                text = 'Defend',
                onSelect = function()
                    self.battleMenu.selection:toggleCursor()
                    gStateStack:pop()
                end
            },
            {
                text = 'Item',
                onSelect = function()
                    self.battleMenu.selection:toggleCursor()
                    gStateStack:push(BattleItemState(self.player, self.activeChar, self.enemies))
                end
            },
            {
                text = 'Run',
                onSelect = function()
                    self.battleMenu.selection:toggleCursor()
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
    -- if the cursor is hidden, make it visible
    if not self.battleMenu.selection.cursor then
        self.battleMenu.selection:toggleCursor()
    end
    self.battleMenu:update(dt)
end

function BattleMenuState:render()
    self.partyStatus:render()
    self.battleMenu:render()
end
