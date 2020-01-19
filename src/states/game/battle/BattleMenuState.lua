--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Battle Menu State --

    This state is pushed when it is the player's turn.  This menu displays
    the various actions which a character can take during their turn as well 
    as displaying the current HP of all party members.
]]

BattleMenuState = Class{__includes = BaseState}


function BattleMenuState:init(player, enemies, index, turn)
    self.player = player
    self.party = player.party
    self.enemies = enemies
    self.activeChar = self.party.members[index]
    self.turn = turn -- the total number of turns that have passed

    local statuses = {}

    for i = 1, #self.party.members do
       
        local item = {
            text = self.party.members[i].name .. ' '
                .. self.party.members[i].currentHP .. '/'
                .. self.party.members[i].stats:get('HP') .. ' HP',
            highlighted = false,
            onSelect = function () end
        }
        if i == index then
            item.highlighted = true
        elseif self.party.members[i].dead then
            item.greyed = true
        end
        table.insert(statuses, item)
    end

    self.partyStatus = Menu {
        x = 0,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        justify = 'left',
        cursor = false,
        items = statuses
    }

    self.battleMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        justify = 'left',
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
                text = 'Magic',
                onSelect = function()
                    self.battleMenu.selection:toggleCursor()
                    gStateStack:push(BattleMagicState(self.activeChar, self.party, self.enemies))
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
                    ACTIONS['run'](self.activeChar, self.enemies[math.random(#self.enemies)],
                    function()
                        -- remove any temporary stat mods
                        for i = 1, #self.party.members do
                            self.party.members[i].stats:clearTempMods()
                        end

                        gStateStack:push(FadeInState(BLACK, 1,
                        function()
                            -- pop off the turn state, and the battle state
                            gStateStack:pop()
                            gStateStack:pop()
                            gMusic['battle']:stop()
                            gMusic['dungeon']:resume()
                            gStateStack:push(FadeOutState(BLACK, 1))
                        end))
                    end)
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
