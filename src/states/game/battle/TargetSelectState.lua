

TargetSelectState = Class{__includes = BaseState}

function TargetSelectState:init(party, enemies, def, callback)
    self.party = party
    self.enemies = enemies

    self.select = def.select
    self.type = def.type
    self.revive = def.revive or false

    self.callback = callback or function() end
    self.targets = {}
    self.selected = false

    if self.select == 'party' then
        self.targets = self.party.members
    else
        self.targets = self.enemies
    end

    local targetList = {}
    for i = 1, #self.targets do
        local item = {}
        if (not self.targets[i].dead and not self.revive) or
            (self.targets[i].dead and self.revive) then
            item = {
                text = self.targets[i].name,
                onSelect = function() 
                    self.selected = true 
                    gStateStack:pop()  
                    self.callback(self.targets[i])        
                end
            }
            table.insert(targetList, item)
        elseif self.select == 'party' then
            item = {
                text = self.targets[i].name,
                greyed = true,
                onSelect = function() end
            }
            table.insert(targetList, item)
        end
    end

    local cancel = {
        text = 'Cancel',
        onSelect = function()
            -- pop back to the battle menu state
            gStateStack:pop()
            gStateStack:pop()
        end
    }
    table.insert(targetList, cancel)

    self.targetMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = 2 * (VIRTUAL_HEIGHT / 3),
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT / 3,
        color = GREY,
        justify = 'left',
        cursor = true,
        items = targetList
    }
end

function TargetSelectState:update(dt)
    if not self.selected then
        self.targetMenu:update(dt)
    end
end

function TargetSelectState:render()
    self.targetMenu:render()
end