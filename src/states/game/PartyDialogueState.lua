--[[
    GD50 
    Final Project

    Author: Daniel Schwartz
    daniel.schwartz.music@gmail.com

    -- Party Dialogue State--

    This state is used to create a cutscene dialogue between two party members.
    This state creates a temporary NPC to represent one of the party members who
    exist only as a member of the player's Party component.  This state takes a chain
    of dialogue states in as a function.

]]

PartyDialogueState = Class{__includes = BaseState}

function PartyDialogueState:init(name, level, dialogue, callback)
    self.level = level
    self.player = level.player
    self.camera = level.camera

    -- dialogue is a function that takes another function 
    -- to resume execution of the chain after it finishes
    self.dialogue = dialogue or function(continue) continue() end
    self.callback = callback or function() end

    self.member = NPC {
        mapX = self.player.mapX,
        mapY =  self.player.mapY,
        width = 16, 
        height = 18,
        animations = CHARACTER_ANIMS[name].field,
        states = {
            ['walk'] = function() return EntityWalkState(self.member, self.level) end,
            ['idle'] = function() return EntityIdleState(self.member) end},
    }
    self.member:changeState('idle')

    -- flag for whether the cut scene has started
    self.playing = false
end

function PartyDialogueState:update(dt)
    if not self.playing then
        Chain(
            function(go)
                self.playing = true
                self.player.direction = 'right'
                self.player:changeState('idle')
                self.member.direction = 'right'
                self.member:changeState('walk', go)
            end,
            function(go)
                self.member:changeState('walk', go)
            end,
            function(go)
                self.member.direction = 'left'
                self.member:changeState('idle')
                self.dialogue(go)
            end,
            function(go)
                self.member:changeState('walk', go)
            end,
            function(go)
                self.member:changeState('walk', go)
            end,
            function(go)
                self.player.direction = 'down'
                self.player:changeState('idle')
                self.member.direction = 'down'
                self.member:changeState('idle')

                -- pop off the dialogue state and execute the callback
                gStateStack:pop()
                self.callback()
            end
        )()    
    end

    self.member:update(dt)
end

function PartyDialogueState:render()
    self.member:render(self.camera)
    self.player:render(self.camera)
end