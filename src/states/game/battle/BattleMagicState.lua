

BattleMagicState = Class{__includes = BaseState}

function BattleMagicState:init(activeChar, party, enemies)
    self.activeChar = activeChar
    self.spells = activeChar.magic.spells
    self.party = party
    self.enemies = enemies
    self.number = Number()
    self.spellCast = false

    local magicList = {}
    for k, spell in pairs(self.spells) do
        table.insert(magicList, {
            text = spell.name .. ' : ' .. spell.mp_cost .. 'MP',
            onSelect = function() 
                if self.activeChar.currentMP >= spell.mp_cost then
                    self.magicMenu.selection:toggleCursor()
                    gStateStack:push(TargetSelectState(self.party, self.enemies, spell.target,
                    function(target)
                        self.spellCast = true
                        ACTIONS[spell.action](spell, self.activeChar, target, self.number,
                        function()
                            gStateStack:pop()
                            gStateStack:pop()
                        end)
                    end))

                end
            end
        })
    end

    table.insert(magicList, {
        text = 'Cancel',
        onSelect = function()
            gStateStack:pop()
        end
    })

    self.magicMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        cursor = true,
        items = magicList
    }
end

function BattleMagicState:update(dt)
    if not self.spellCast then
        self.magicMenu:update(dt)
    end
end

function BattleMagicState:render()
    if not self.spellCast then
        self.magicMenu:render()
    end
    self.number:render()
end