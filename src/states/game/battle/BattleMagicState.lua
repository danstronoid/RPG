

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
        local greyed = false
        if spell.mp_cost > self.activeChar.currentMP then
            greyed = true
        end
        table.insert(magicList, {
            text = spell.name .. ' : ' .. spell.mp_cost .. ' MP',
            greyed = greyed,
            onSelect = function()
                if self.activeChar.currentMP >= spell.mp_cost then
                    self.magicMenu.selection:toggleCursor()
                    gStateStack:push(TargetSelectState(self.party, self.enemies, spell.target,
                    function(target)
                        local target = target
                        self.spellCast = true
                        gStateStack:push(PopUpState(spell.name, 1,
                        function()
                            ACTIONS[spell.action](spell, self.activeChar, target, self.number,
                            function()
                                gStateStack:pop()
                                gStateStack:pop()
                            end)
                        end))
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

    local statuses = {}

    for i = 1, #self.party.members do
       
        local item = {
            text = self.party.members[i].name .. ' '
                .. self.party.members[i].currentMP .. '/'
                .. self.party.members[i].stats:get('MP') .. ' MP',
            highlighted = false,
            onSelect = function () end
        }
        if self.party.members[i].name == self.activeChar.name then
            item.highlighted = true
        elseif self.party.members[i].dead then
            item.greyed = true
        end
        table.insert(statuses, item)
    end

    self.magicStats =  Menu {
        x = 0,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        justify = 'left',
        cursor = false,
        items = statuses
    }
end

function BattleMagicState:update(dt)
    if not self.spellCast then
        self.magicMenu:update(dt)
    end
end

function BattleMagicState:render()
    if not self.spellCast then
        self.magicStats:render()
        self.magicMenu:render()
    end
    self.number:render()
end